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
    
    # Public: Open a file as a string.
    #
    # file - Full path String name of a html or markdown file.
    #
    # Returns a String.
    def self.open_as_string file
      string = IO.read file
      if file.markdown_ext?
        BlueCloth.new(string).to_html 
      else
        string
      end
    end
    
    # Public: Open a file as a string, taking care of fragment tags.
    # All fragment tags are replaced by a new content.
    #
    # file - Full path String name of a html or markdown file.
    #
    # Returns a String.
    def self.build_page_content(file, working_dir)
      # TODO éviter le working_dir
      if file.markdown_ext?
        BlueCloth.new(IO.read(file)).to_html
      else
        Fragment.new(file, working_dir).to_html
      end
    end
    
    # Public: Get the list of <genit> tag in a document.
    #
    # file - Nokogiri::HTML or Nokogiri::XML document.
    #
    # Returns a list of Nokogiri::XML::NodeSet.
    def self.genit_tags_from file
      file.css "genit"
    end
    
  end

end
