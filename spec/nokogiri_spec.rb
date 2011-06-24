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
    @doc.css("body genit").size.should == 1
  end
  
  it "should retrieve a tag" do
    @doc.at_css("body genit").to_s.should == '<genit class="pages"></genit>'
  end
  
  it "should retrieve class of tag" do
    @doc.at_css("body genit")['class'].should == "pages"
  end
  
end
