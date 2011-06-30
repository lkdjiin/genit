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
  
end
