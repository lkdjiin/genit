# -*- encoding: utf-8 -*-

require './spec/helper'

describe ClassTag do

  it "should raise error if class is unknown" do
    tag = {'class' => 'unknown'}
    ct = ClassTag.new 'mock', 'mock', 'mock', tag
    lambda{ct.process}.should raise_error(RuntimeError)
  end

end
