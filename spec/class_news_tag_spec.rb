# -*- encoding: utf-8 -*-

require './spec/helper'

describe ClassNewsTag do

  after :all do
    clean_test_repository
  end
  
  def create_sample_project
    FileUtils.makedirs('spec/project-name/news')
    File.open('spec/project-name/news/2011-01-01.html', "w") {|out| out.puts '<h1>2011-01-01</h1>' }
    File.open('spec/project-name/news/2011-02-02.html', "w") {|out| out.puts '<h1>2011-02-02</h1>' }
  end

  it "should replace all news" do
    create_sample_project
    template = Nokogiri::XML.fragment '<genit class="news"/>'
    tag = {'class' => 'news'}
    cnt = ClassNewsTag.new 'spec/project-name', template, 'mock', tag
    doc = cnt.process
    doc.css('h1').size.should == 2
  end
  
  it "should replace X news" do
    create_sample_project
    template = Nokogiri::XML.fragment '<genit class="news" number="1"/>'
    tag = {'class' => 'news', 'number' => '1'}
    cnt = ClassNewsTag.new 'spec/project-name', template, 'mock', tag
    doc = cnt.process
    doc.css('h1').size.should == 1
    doc.css('h1').inner_html.should == '2011-02-02'
  end

end
