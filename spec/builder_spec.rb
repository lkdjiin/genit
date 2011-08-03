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
  
  it "should set the menu" do
    menu = Nokogiri::XML(File.open("data/templates/menu.html"))
    builder = MenuBuilder.new(menu)
    menu = builder.build_for_page('index.html')
    menu.css("ul#menu a#selected").size.should == 1
    menu.css("ul#menu a#selected").first['href'].should == 'index.html'
  end
  
end
