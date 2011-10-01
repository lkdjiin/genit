# -*- encoding: utf-8 -*-

require './spec/helper'

describe NewsUtils do

  describe "#get_date_from_filename" do
    it "should get the date from a news filename" do
      result = NewsUtils.get_date_from_filename "2011-10-01.html"
      result.should eql "2011-10-01"
    end
  end

end
