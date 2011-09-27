# -*- encoding: utf-8 -*-

require './spec/helper'

describe PagesFinder do

  before :each do
    @project = ProjectCreator.new('spec/project-name', 'html_5', false)
    @project.create
    @finder = PagesFinder.new 'spec/project-name'
  end
  
  after :each do
    clean_test_repository
  end
  
  def write_file name, content
    File.open(File.join('spec/project-name', name), "w") do |file| 
      file.puts content
    end
  end

  it "should retrieve the right number of pages" do
    write_file 'pages/a.html', '<h1>a</h1>'
    write_file 'pages/b.html', '<h1>b</h1>'
    @finder.find.size.should == 3
  end
  
  it "should name the pages from the root" do
    write_file 'pages/a.html', '<h1>a</h1>'
    write_file 'pages/b.html', '<h1>b</h1>'
    list = @finder.find
    list.include?("index.html").should be_true
    list.include?("a.html").should be_true
    list.include?("b.html").should be_true
  end
  
  it "should take care of markdown files" do
    write_file 'pages/a.markdown', '#a'
    write_file 'pages/b.markdown', '#b'
    list = @finder.find
    list.size.should == 3
    list.include?("index.html").should be_true
    list.include?("a.html").should be_true
    list.include?("b.html").should be_true
  end
  
  it "should transform an array of pagenames into an array of URL strings" do
    pagenames = ['a.html', 'b.html', 'c/d.html']
    url = 'http://www.example.com'
    result = PagesFinder.pagenames2urls(pagenames, url)
    result.size.should == 3
    result.include?('http://www.example.com/a.html').should be_true
    result.include?('http://www.example.com/b.html').should be_true
    result.include?('http://www.example.com/c/d.html').should be_true
  end
  
end
