# -*- encoding: utf-8 -*-

require './spec/helper'

describe TagProcessor do

  it "should abort on unknown tag" do
    doc = Nokogiri::XML.fragment('<body><genit foo="bar"/></body>')
    tag = doc.at_css('genit')
    STDOUT.should_receive(:puts).with("Genit aborted! Unknown tag: <genit foo=\"bar\"/>")
    lambda do
      TagProcessor.new('mock', 'mock', 'mock', tag)
    end.should raise_error(SystemExit)
  end

end
