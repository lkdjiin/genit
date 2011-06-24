# -*- encoding: utf-8 -*-

require './spec/helper'

describe Builder do

  before :all do
    @template = Nokogiri::HTML(File.open("data/templates/main.html"))
  end

  it "should replace a css rule by a string" do
    builder = Builder.new(@template)
    doc = builder.replace('genit.pages', "<working />")
    doc.css("body working").size.should == 1
  end
  
end
