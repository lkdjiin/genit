# -*- encoding: utf-8 -*-

require 'nokogiri'

module Genit

  class HtmlDocument
  
    def self.open file
      Nokogiri::HTML(File.open(file))
    end
    
    def self.open_as_string file
      IO.read file
    end
    
  end

end
