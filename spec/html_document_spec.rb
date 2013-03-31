# -*- encoding: utf-8 -*-

require './spec/helper'

describe HtmlDocument do

  it "should load as a document" do
    doc = HtmlDocument.open("data/templates/main.html")
    doc.css("body genit").size.should >= 1
  end

  it "should load html as a string" do
    content = HtmlDocument.open_as_string("data/pages/index.html")
    content.class.should == String
    content.size.should > 0
  end

  it "should load markdown as a string" do
    content = HtmlDocument.open_as_string("spec/test-files/test.markdown")
    content.should == '<h1>title</h1>'
  end

  it "should extract the list of genit tags" do
    doc = HtmlDocument.open("data/templates/main.html")
    tags = HtmlDocument.genit_tags_from doc
    tags.size.should == 2
  end

  it "should build a page content from markdown" do
    content = HtmlDocument.build_page_content("spec/test-files/test.markdown",
                                              'spec/test-files')
    content.should == '<h1>title</h1>'
  end

  it "should build a page content from haml" do
    content = HtmlDocument.build_page_content("spec/test-files/test.haml", 
                                              'spec/test-files')
    content.should == "<h1>title</h1>\n"
  end

  it "should build page content from html" do
    content = HtmlDocument.build_page_content(
      "spec/test-files/fragment.html", 
      'spec/test-files')
    content.start_with?('<h1>title</h1>').should be_true
  end

end
