# -*- encoding: utf-8 -*-

require './spec/helper'

describe Compiler do

  before :each do
    @project = ProjectCreator.new('spec/project-name', 'html_5', false)
    @project.create
    @compiler = Compiler.new test_project_path
  end
  
  after :each do
    clean_test_repository
  end
  
  def write_file name, content
    File.open(File.join('spec/project-name', name), "w") do |file| 
      file.puts content
    end
  end
  
  it "should build an index.html page in www" do
    @compiler.compile
    File.exist?('spec/project-name/www/index.html').should be_true
  end
  
  it "should build two pages" do
    write_file 'pages/doc.html', '<h1>documentation</h1>'
    @compiler.compile
    File.exist?('spec/project-name/www/index.html').should be_true
    File.exist?('spec/project-name/www/doc.html').should be_true
  end
    
  it "should copy the styles/ into www/" do
    @compiler.compile
    File.exist?('spec/project-name/www/styles/screen.css').should be_true
  end
  
  it "should set the menu in index page" do
    @compiler.compile
    doc = Nokogiri::HTML(File.open("spec/project-name/www/index.html"))
    doc.at_css("ul#menu a#selected")['href'].should == 'index.html'
  end
  
  context "with no '.genit' file" do
    it "should exit" do
      $stdout.should_receive(:puts).with(/Not a genit project folder/i)
      lambda{Compiler.new File.expand_path('.')}.should raise_error(SystemExit)
    end
  end
  
  context "with no '.config' file" do
    it "should exit" do
      $stdout.should_receive(:puts).with(/Missing config file/i)
      FileUtils.rm 'spec/project-name/.config'
      lambda{Compiler.new test_project_path}.should raise_error(SystemExit)
    end
  end
  
  describe "RSS feed" do
    it "should build the rss.xml file" do
      @compiler.compile
      File.exist?('spec/project-name/www/rss.xml').should be_true
    end
  end
  
  describe "Sitemap XML" do
    it "should build the 'sitemap.xml'" do
      a_news = %q{<h1>title</h1>}
      File.open('spec/project-name/news/2011-10-01.html', "w") {|out| out.puts a_news }
      @compiler.compile
      File.exist?('spec/project-name/www/sitemap.xml').should be_true
    end
  end
  
  context "with bad tag syntax" do
    context "with unknown class into template" do
      it "should exit" do
        # replace main.html
        main = %q{
          <html>
            <body>
              <genit class="foo"/>
            </body>
          </html>
        }
        File.open('spec/project-name/templates/main.html', "w") {|out| out.puts main }
        
        $stdout.should_receive(:puts).with(/Unknown tag <genit class="foo"/i)
        lambda{Compiler.new(test_project_path).compile}.should raise_error(SystemExit)
      end
    end
    
    context "with unknown class into page" do
      it "should exit" do
        # replace index.html
        index = %q{<genit class="foo"/>}
        File.open('spec/project-name/pages/index.html', "w") {|out| out.puts index }
        
        $stdout.should_receive(:puts).with(/Unknown tag <genit class="foo"/i)
        lambda{Compiler.new(test_project_path).compile}.should raise_error(SystemExit)
      end
    end
    
    context "with incomplete fragment tag into template" do
      it "should exit" do
        # replace main.html
        main = %q{
          <html>
            <body>
              <genit class="fragment"/>
            </body>
          </html>
        }
        File.open('spec/project-name/templates/main.html', "w") {|out| out.puts main }
        
        $stdout.should_receive(:puts).with(/Incomplete <genit class="fragment"/i)
        lambda{Compiler.new(test_project_path).compile}.should raise_error(SystemExit)
      end
    end
    
    context "with incomplete fragment tag into page" do
      it "should exit" do
        # replace index.html
        index = %q{<genit class="fragment"/>}
        File.open('spec/project-name/pages/index.html', "w") {|out| out.puts index }
        
        $stdout.should_receive(:puts).with(/Incomplete <genit class="fragment"/i)
        lambda{Compiler.new(test_project_path).compile}.should raise_error(SystemExit)
      end
    end
    
    context "with unknown file in fragment tag into template" do
      it "should exit" do
        # replace main.html
        main = %q{
          <html>
            <body>
              <genit class="fragment" file="unknown.html"/>
            </body>
          </html>
        }
        File.open('spec/project-name/templates/main.html', "w") {|out| out.puts main }
        
        $stdout.should_receive(:puts).with(/No such file <genit class="fragment" file=/i)
        lambda{Compiler.new(test_project_path).compile}.should raise_error(SystemExit)
      end
    end
    
    context "with unknown file in fragment tag into page" do
      it "should exit" do
        # replace index.html
        index = %q{<genit class="fragment" file="unknown.html"/>}
        File.open('spec/project-name/pages/index.html', "w") {|out| out.puts index }
        
        $stdout.should_receive(:puts).with(/No such file <genit class="fragment" file=/i)
        lambda{Compiler.new(test_project_path).compile}.should raise_error(SystemExit)
      end
    end
    
    context "with here tag without what tag" do
      it "should warn" do
        # replace main.html
        main = %q{
          <html>
            <body>
              
              <genit class="pages"/>
              <genit here="foo"/>
            </body>
          </html>
        }
        File.open('spec/project-name/templates/main.html', "w") {|out| out.puts main }
        $stdout.should_receive(:puts).with(/here without what/i)
        #~ lambda{Compiler.new(test_project_path).compile}.should_not raise_error
        Compiler.new(test_project_path).compile
      end
    end
    
    context "with what tag without here tag" do
      it "should warn"
    end
    
  end
  
  context "with bad '.config' syntax" do
    it "should exit" do
      # replace .config
      main = 
%q{--- 
:address: http://www.example.com
:rss: true
 :rss_title: RSS TITLE
:rss_description: RSS DESCRIPTION
}
      File.open('spec/project-name/.config', "w") {|out| out.puts main }
      
      $stdout.should_receive(:puts).with(/in .config file/i)
      lambda{Compiler.new(test_project_path).compile}.should raise_error(SystemExit)
    end
  end
  
  describe "BUGS" do
  
    it "should allow template to include a fragment (Bug#37)" do
      # add a fragment
      File.open('spec/project-name/fragments/footer.html', "w") {|out| out.puts '<p>footer</p>' }
      # replace main.html
      main = %q{
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
          <title>Genit - Static web site framework</title>
          <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
          <link rel="stylesheet" type="text/css" media="all" href="styles/alsa/all.css" /> 
          <link rel="stylesheet" type="text/css" media="screen" href="styles/screen.css" /> 
          <link rel="stylesheet" type="text/css" media="print" href="styles/print.css" /> 
        </head>
        <body>
          <genit class="menu" />
          <genit class="pages" />
          <genit class="fragment" file="footer.html"/>
        </body>
      </html>}
      File.open('spec/project-name/templates/main.html', "w") {|out| out.puts main }
      lambda {@compiler.compile}.should_not raise_error
    end
  
  end
  
end
