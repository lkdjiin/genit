# -*- encoding: utf-8 -*-

require './spec/helper'

describe XmlDocument do

  it "should load as a document" do
    doc = XmlDocument.open("data/templates/menu.html")
    doc.css("ul#menu li").size.should >= 1
  end
  
  it "should load as a fragment" do
    doc = XmlDocument.open_fragment("data/templates/menu.html")
    doc.css("ul#menu li").size.should >= 1
  end

  it "should exit on malformed document" do
    lambda do
      XmlDocument.open("spec/test-files/malformed.html") 
    end.should raise_error(SystemExit)
  end
end
