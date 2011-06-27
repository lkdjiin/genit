# -*- encoding: utf-8 -*-

require './spec/helper'
require 'nokogiri'

describe "Nokogiri library" do

  before :all do
    f = File.open("data/templates/main.html")
    @doc = Nokogiri::HTML(f)
    f.close
  end

  it "should retrieve all genit tag" do
    @doc.css("body genit").size.should == 2
  end
  
  it "should retrieve class of tag" do
    tags = @doc.css("body genit")
    tags[0]['class'].should == "menu"
    tags[1]['class'].should == "pages"
  end
  
  it "should add an attribute" do
    @doc.at_css("body")['class'] = "main"
    @doc.at_css("body")['class'].should == 'main'
  end
  
end
