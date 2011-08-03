# -*- encoding: utf-8 -*-

require './spec/helper'

describe FileWriter do

  after :all do
    clean_test_repository
  end

  it "should create dirs if they doesn't exist" do
    test_file = 'spec/project-name/dir1/dir2/test.file'
    FileWriter.write 'content', test_file
    File.exists?(test_file).should == true
  end

end
