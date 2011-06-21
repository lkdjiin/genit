# -*- encoding: utf-8 -*-

require './spec/helper'

describe ProjectCreator do

  before :all do
    @project = ProjectCreator.new('spec/project-name')
  end
  
  after :all do
    clean_test_repository
  end

  it "should create a project folder" do
    @project.create
    File.exist?('spec/project-name').should == true
  end
  
  it "should say it if it cannot create a project" do
		project = ProjectCreator.new('/root/project')
    $stdout.should_receive(:puts).with("Cannot create project...")
    project.create
	end

  it "should create a news folder" do
    @project.create
    File.exist?('spec/project-name/news').should == true
  end
  
  it "should create a pages folder" do
    @project.create
    File.exist?('spec/project-name/pages').should == true
  end
  
  it "should create a scripts folder" do
    @project.create
    File.exist?('spec/project-name/scripts').should == true
  end
  
  it "should create a styles folder" do
    @project.create
    File.exist?('spec/project-name/styles').should == true
  end
  
  it "should create a templates folder" do
    @project.create
    File.exist?('spec/project-name/templates').should == true
  end
  
  it "should create a www folder" do
    @project.create
    File.exist?('spec/project-name/www').should == true
  end
  
  it "should create a css folder inside the styles" do
    @project.create
    File.exist?('spec/project-name/styles/css').should == true
  end
  
  it "should create a css/alsa folder inside the styles" do
    @project.create
    File.exist?('spec/project-name/styles/css/alsa').should == true
  end
  
  it "should create a css/yui folder inside the styles" do
    @project.create
    File.exist?('spec/project-name/styles/css/yui').should == true
  end
  
  it "should create a images folder inside the styles" do
    @project.create
    File.exist?('spec/project-name/styles/images').should == true
  end
  
end
