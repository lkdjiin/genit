# -*- encoding: utf-8 -*-

require './spec/helper'

describe ProjectCreator do

  before :all do
    @project = ProjectCreator.new('spec/project-name', false)
    @project.create
  end

  after :all do
    clean_test_repository
  end

  describe "Project folder" do

    it "should create a project folder" do
      File.exist?('spec/project-name').should == true
    end

    it "should create a project folder with version number" do
      a = File.read('VERSION').strip
      b = File.read('spec/project-name/.genit').strip
      b.should eql a
    end

    it "should say it if it cannot create a project" do
      project = ProjectCreator.new('/root/project', false)
      $stdout.should_receive(:puts).with("Cannot create project...")
      project.create
    end

    it "should create a project file" do
      File.exist?('spec/project-name/.genit').should == true
    end

    it "should create a config file" do
      File.exist?('spec/project-name/config').should == true
    end

  end

  describe "Config file" do

    before :each do
      @config_file = YAML.load_file('spec/project-name/config')
    end

    it "should have an address value of 'http://www.example.com'" do
      @config_file[:address].should == 'http://www.example.com'
    end

    it "should have an rss value at true" do
      @config_file[:rss].should be_true
    end

    it "should have an rss_title value of 'RSS TITLE'" do
      @config_file[:rss_title].should == 'RSS TITLE'
    end

    it "should have an rss_description value of 'RSS DESCRIPTION'" do
      @config_file[:rss_description].should == 'RSS DESCRIPTION'
    end

  end

  describe "Folder structure" do

    it "should create a news folder" do
      File.exist?('spec/project-name/src/news').should == true
    end

    it "should create a fragments folder" do
      File.exist?('spec/project-name/src/fragments').should == true
    end

    it "should create a pages folder" do
      File.exist?('spec/project-name/src/pages').should == true
    end

    it "should create a scripts folder" do
      File.exist?('spec/project-name/scripts').should == true
    end

    it "should create a styles folder" do
      File.exist?('spec/project-name/styles').should == true
    end

    it "should create a templates folder" do
      File.exist?('spec/project-name/src/templates').should == true
    end

    it "should not create a www folder" do
      File.exist?('spec/project-name/www').should == false
    end

    it "should create a alsa folder inside the styles" do
      File.exist?('spec/project-name/styles/alsa').should == true
    end

    it "should create a yui folder inside the styles" do
      File.exist?('spec/project-name/styles/yui').should == true
    end

    it "should create a images folder inside the styles" do
      File.exist?('spec/project-name/styles/images').should == true
    end

    it "should create a public folder" do
      File.exist?('spec/project-name/public').should == true
    end

  end # "Folder structure"


  describe "The templates folder" do
    it "should have got templates/main.html" do
      File.exist?('data/templates/main.html').should be_true
    end

    it "should copy templates/main.html" do
      File.exist?('spec/project-name/src/templates/main.html').should be_true
    end

    it "should have got templates/menu.html" do
      File.exist?('data/templates/menu.html').should be_true
    end

    it "should copy templates/menu.html" do
      File.exist?('spec/project-name/src/templates/menu.html').should be_true
    end

  end # "The templates folder"

  describe "The pages folder" do
    it "should have got pages/index.html" do
      File.exist?('data/pages/index.html').should be_true
    end

    it "should copy pages/index.html" do
      File.exist?('spec/project-name/src/pages/index.html').should be_true
    end
  end # "The pages folder"

  describe "The styles folder" do
    it "should have got styles/handheld.css" do
      File.exist?('data/styles/handheld.css').should be_true
    end

    it "should copy styles/handheld.css" do
      File.exist?('spec/project-name/styles/handheld.css').should be_true
    end

    it "should have got styles/print.css" do
      File.exist?('data/styles/print.css').should be_true
    end

    it "should copy styles/print.css" do
      File.exist?('spec/project-name/styles/print.css').should be_true
    end

    it "should have got styles/screen.css" do
      File.exist?('data/styles/screen.css').should be_true
    end

    it "should copy styles/screen.css" do
      File.exist?('spec/project-name/styles/screen.css').should be_true
    end

    it "should have got styles/alsa/all.css" do
      File.exist?('data/styles/alsa/all.css').should be_true
    end

    it "should copy styles/alsa/all.css" do
      File.exist?('spec/project-name/styles/alsa/all.css').should be_true
    end

    it "should have got styles/yui/all.css" do
      File.exist?('data/styles/yui/all.css').should be_true
    end

    it "should copy styles/yui/all.css" do
      File.exist?('spec/project-name/styles/yui/all.css').should be_true
    end

    it "should have got styles/yui/base.css" do
      File.exist?('data/styles/yui/base.css').should be_true
    end

    it "should copy styles/yui/base.css" do
      File.exist?('spec/project-name/styles/yui/base.css').should be_true
    end

    it "should have got styles/yui/fonts.css" do
      File.exist?('data/styles/yui/fonts.css').should be_true
    end

    it "should copy styles/yui/fonts.css" do
      File.exist?('spec/project-name/styles/yui/fonts.css').should be_true
    end

    it "should have got styles/yui/reset.css" do
      File.exist?('data/styles/yui/reset.css').should be_true
    end

    it "should copy styles/yui/reset.css" do
      File.exist?('spec/project-name/styles/yui/reset.css').should be_true
    end

  end #  "The styles folder"



end
