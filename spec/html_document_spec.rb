# -*- encoding: utf-8 -*-

require './spec/helper'

describe HtmlDocument do

  it "should load as a document" do
    doc = HtmlDocument.open("data/templates/main.html")
    doc.css("body genit").size.should >= 1
  end
  
  it "should load as a string" do
    content = HtmlDocument.open_as_string("data/pages/index.html")
    content.class.should == String
    content.size.should > 0
  end
  
end