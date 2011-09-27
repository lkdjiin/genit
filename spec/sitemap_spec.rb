# -*- encoding: utf-8 -*-

require './spec/helper'

describe Sitemap do

  before :each do
    @sitemap = Sitemap.new ['a.html', 'b.html', 'c.html']
  end

  it "should return a string" do
    @sitemap.get.class.should == String
  end
  
  it "should have tonly one <urlset> element" do
    doc = Nokogiri::XML::Document.parse @sitemap.get
    doc.css("urlset").size.should == 1
  end
  
  it "should have the right <urlset> element" do
    @sitemap.get.match('http://www.sitemaps.org/schemas/sitemap/0.9').should_not be_nil
  end
  
  it "should have the right number of <url> elements" do
    doc = Nokogiri::XML::Document.parse @sitemap.get
    doc.css("url").size.should == 3
  end
  
  describe "<url> element" do
  
    it "should have the right <loc> element" do
      doc = Nokogiri::XML::Document.parse @sitemap.get
      list = doc.css("url loc").to_a
      list = list.map { |e| e.inner_html }
      list.include?('a.html').should be_true
      list.include?('b.html').should be_true
      list.include?('c.html').should be_true
    end
    
  end
  
end
