# -*- encoding: utf-8 -*-

require 'nokogiri'
require 'bluecloth'

module Genit

  # Open an xml file.
  class XmlDocument
  
    # Public: Open an xml document.
    #
    # file - Full path String filename.
    #
    # Returns a Nokogiri::XML document.
    def self.open file
      Nokogiri::XML(File.open(file))
    end
    
    # Public: Open a fragment of xml document.
    #
    # file - Full path String filename.
    #
    # Returns a Nokogiri::XML document.
    def self.open_fragment file
      string = IO.read file
      Nokogiri::XML.fragment string
    end
    
  end

end
