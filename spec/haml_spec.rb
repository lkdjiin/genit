# -*- encoding: utf-8 -*-

require './spec/helper'

describe "Haml expectations" do

  before :all do
    Haml::Options.defaults[:format] = :xhtml
  end

  it "should accept and close the genit tag" do
    e = Haml::Engine.new("%genit")
    e.render.should == "<genit></genit>\n"
  end
end
