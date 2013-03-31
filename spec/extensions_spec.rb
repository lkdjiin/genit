# -*- encoding: utf-8 -*-

require './spec/helper'

describe "Standard class String extensions" do

  it "should replace a markdown file ext" do
    "file.markdown".force_html_extension.should == "file.html"
  end

  it "should replace a haml file ext" do
    "file.haml".force_html_extension.should == "file.html"
  end

  it "should replace a markdown file ext !" do
    string = "file.markdown"
    string.force_html_extension!
    string.should == "file.html"
  end

  it "should replace a haml file ext !" do
    string = "file.haml"
    string.force_html_extension!
    string.should == "file.html"
  end

  it "should not replace an other file ext" do
    "file.txt".force_html_extension.should == "file.txt"
  end

  it "should not replace an other file ext !" do
    string = "file.txt"
    string.force_html_extension!
    string.should == "file.txt"
  end

  it "should say if it has a markdown file extension" do
    "file.markdown".markdown_ext?.should be_true
  end

  it "should say if it has a haml file extension" do
    "file.haml".haml_ext?.should be_true
  end

  it "should say if it has not a markdown file extension" do
    "file.other".markdown_ext?.should be_false
  end

  it "should say if it has not a haml file extension" do
    "file.other".haml_ext?.should be_false
  end

end
