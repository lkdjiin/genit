# -*- encoding: utf-8 -*-

require './spec/helper'

describe Fragment do

  it "should replace one fragment tag" do
    fragment = Fragment.new("spec/test-files/fragment.html", 'spec/test-files')
    fragment.to_html.start_with?('<h1>title</h1>').should be_true
  end
  
  it "should replace one fragment tag among other tags" do
    fragment = Fragment.new("spec/test-files/fragment4.html", 'spec/test-files')
    result = fragment.to_html
    result.gsub!("\n", '')
    result.should == '<h1>title</h1><p>para</p><p>footer</p>'
  end
  
  it "should replace one fragment tag in markdown" do
    fragment = Fragment.new("spec/test-files/fragment3.html", 'spec/test-files')
    fragment.to_html.start_with?('<h1>title</h1>').should be_true
  end
  
  it "should replace some fragment tags" do
    fragment = Fragment.new("spec/test-files/fragment2.html", 'spec/test-files')
    result = fragment.to_html.gsub("\n", '')
    result.should == ("<p>abcde</p>")
  end

  it "should not change a file without fragment tag" do
    fragment = Fragment.new("spec/test-files/nothing.html", 'spec/test-files')
    fragment.to_html.start_with?("<h1>title</h1>").should be_true
  end
  
end
