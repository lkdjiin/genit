# -*- encoding: utf-8 -*-

require './spec/helper'

describe Compiler do

  before :all do
    @project = ProjectCreator.new('spec/project-name')
    @project.create
    @compiler = Compiler.new File.expand_path('spec/project-name')
  end
  
  after :all do
    clean_test_repository
  end

  it "should build an index.html page in www" do
    @compiler.compile
    File.exist?('spec/project-name/www/index.html').should == true
  end
  
end
