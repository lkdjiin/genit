# -*- encoding: utf-8 -*-

require './spec/helper'

describe "sass expectations" do

  it "should keep the render API" do
    e = Sass::Engine.new ""
    e.should respond_to :render
  end
end
