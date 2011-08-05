# -*- encoding: utf-8 -*-

require './spec/helper'

describe MenuBuilder do

  before :each do
    menu_test = %q{
    <ul id="menu">
      <li><a href="index.html">home</a></li>
      <li><a href="about.html">about</a></li>
      <li><a href="doc/index.html">doc</a></li>
      <li><a href="doc/a.html">doca</a></li>
      <li><a href="doc/b.html">docb</a></li>
      <li><a href="a/b/c1.html">abc1</a></li>
      <li><a href="a/b/c2.html">abc2</a></li>
      <li><a href="/absolute.html">absolute</a></li>
      <li><a href="http://www.truc.com/file.html">file</a></li>
    </ul>}
    @menu_doc = Nokogiri::XML.fragment menu_test
  end

  it "should set the menu for index.html page" do
    builder = MenuBuilder.new(@menu_doc)
    new_menu = builder.build_for_page('index.html')
    new_menu.css("ul#menu a#selected").size.should == 1
    new_menu.css("ul#menu a#selected").first['href'].should == 'index.html'
  end
  
  it "should set the menu for about.html page" do
    builder = MenuBuilder.new(@menu_doc)
    new_menu = builder.build_for_page('about.html')
    new_menu.css("ul#menu a#selected").size.should == 1
    new_menu.css("ul#menu a#selected").first['href'].should == 'about.html'
  end
  
  #~ it "should set the menu for doc/index.html page" do
    #~ builder = MenuBuilder.new(@menu_doc)
    #~ new_menu = builder.build_for_page('doc/index.html')
    #~ new_menu.css("ul#menu a#selected").size.should == 1
    #~ new_menu.css("ul#menu a#selected").first['href'].should == '../doc/index.html'
  #~ end
  #~ 
  #~ it "should set the menu for a/b/c2.html page" do
    #~ builder = MenuBuilder.new(@menu_doc)
    #~ new_menu = builder.build_for_page('a/b/c2.html')
    #~ new_menu.css("ul#menu a#selected").size.should == 1
    #~ new_menu.css("ul#menu a#selected").first['href'].should == '../../a/b/c2.html'
  #~ end
  
  it "should set the menu for /absolute.html page" do
    builder = MenuBuilder.new(@menu_doc)
    new_menu = builder.build_for_page('/absolute.html')
    new_menu.css("ul#menu a#selected").size.should == 1
    new_menu.css("ul#menu a#selected").first['href'].should == '/absolute.html'
  end
  
  it "should set the menu for http://www.truc.com/file.html page" do
    builder = MenuBuilder.new(@menu_doc)
    new_menu = builder.build_for_page('http://www.truc.com/file.html')
    new_menu.css("ul#menu a#selected").size.should == 1
    new_menu.css("ul#menu a#selected").first['href'].should == 'http://www.truc.com/file.html'
  end

end
