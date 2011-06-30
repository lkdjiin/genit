# -*- encoding: utf-8 -*-

require 'nokogiri'
require 'bluecloth'

module Genit

  # Open an html file in various format.
  class HtmlDocument
  
    # Public: Open a html document.
    #
    # file - Full path String filename.
    #
    # Returns a Nokogiri::HTML document.
    def self.open file
      Nokogiri::HTML(File.open(file))
    end
    
    # Public: Open a html or markdown file as a string.
    #
    # file - Full path String name of a html or markdown file.
    #
    # Returns a String.
    def self.open_as_string file
      string = IO.read file
      string = BlueCloth.new(string).to_html if file.end_with? '.markdown'
      string
    end
    
    # Public: Get the list of <genit> tag in a document.
    #
    # file - Nokogiri::HTML document.
    #
    # Returns a list of Nokogiri::XML::NodeSet.
    def self.genit_tags_from file
      file.css "genit"
    end
    
  end

end
