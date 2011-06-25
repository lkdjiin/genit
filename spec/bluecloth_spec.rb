# -*- encoding: utf-8 -*-

require './spec/helper'
require 'bluecloth'

describe "BlueCloth library" do

  it "should convert markdown to html" do
    BlueCloth.new("#title").to_html.should == '<h1>title</h1>'
  end
  
end
