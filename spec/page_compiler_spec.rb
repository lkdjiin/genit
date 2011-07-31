# -*- encoding: utf-8 -*-

require './spec/helper'

describe PageCompiler do

  after :all do
    clean_test_repository
  end
  
  def create_sample_project
    FileUtils.makedirs('spec/project-name/templates')
    FileUtils.makedirs('spec/project-name/pages')
    File.open('spec/project-name/templates/main.html', "w") {|out| out.puts '<h1><genit var="title"/></h1>' }
    File.open('spec/project-name/pages/index.html', "w") {|out| out.puts '<genit var="title">My Title</genit>' }
  end
  
  it "should substitute a variable" do
    create_sample_project
    pc = PageCompiler.new 'spec/project-name/', 'index.html'
    doc = pc.compile
    doc.at_css('h1').inner_html.should == 'My Title'
  end

end
