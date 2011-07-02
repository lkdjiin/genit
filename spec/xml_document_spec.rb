# -*- encoding: utf-8 -*-

require './spec/helper'

describe XmlDocument do

  it "should load as a document" do
    doc = XmlDocument.open("data/templates/menu.html")
    doc.css("ul#menu li").size.should >= 1
  end

end
