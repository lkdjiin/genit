# -*- encoding: utf-8 -*-

require './spec/helper'

describe BuilderBase do

  before :each do
    test_file = %q{<body></body>}
    @doc = Nokogiri::XML.fragment test_file
  end
  
  it "should not be instanciated" do
    builder = BuilderBase.new(@doc)
    lambda {builder.build_for_page('index.html')}.should raise_error(NotImplementedError)
  end

end
