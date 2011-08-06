# -*- encoding: utf-8 -*-

require './spec/helper'

describe Compiler do

  before :all do
    @project = ProjectCreator.new('spec/project-name')
    @project.create
    @compiler = Compiler.new File.expand_path('spec/project-name')
  end
  
  after :all do
    clean_test_repository
  end
  
  def write_file name, content
    File.open(File.join('spec/project-name', name), "w") do |file| 
      file.puts content
    end
  end
  
  it "should build an index.html page in www" do
    @compiler.compile
    File.exist?('spec/project-name/www/index.html').should == true
  end
  
  it "should build two pages" do
    write_file 'pages/doc.html', '<h1>documentation</h1>'
    @compiler.compile
    File.exist?('spec/project-name/www/index.html').should == true
    File.exist?('spec/project-name/www/doc.html').should == true
  end
    
  it "should copy the styles/ into www/" do
    File.exist?('spec/project-name/www/styles/screen.css').should be_true
  end
  
  it "should set the menu in index page" do
    @compiler.compile
    doc = Nokogiri::HTML(File.open("spec/project-name/www/index.html"))
    doc.at_css("ul#menu a#selected")['href'].should == 'index.html'
  end
  
  it "should take care of the hidden project file" do
    compiler = Compiler.new File.expand_path('.')
    $stdout.should_receive(:puts).with("Not a genit project folder")
    compiler.compile
  end
  
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
