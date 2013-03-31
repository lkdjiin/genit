# -*- encoding: utf-8 -*-

require 'nokogiri'
require 'bluecloth'
require 'haml'

module Genit

  # Open an html file in various format.
  class HtmlDocument

    # Public: Open an entire html document.
    # If the file does not contain a <bogy> tag, a doctype, etc, they will be
    # automatically added.
    #
    # file - Full path String filename.
    #
    # Returns a Nokogiri::HTML document.
    def self.open file
      Nokogiri::HTML(File.open(file))
    end

    # Public: Open a fragment of html document.
    #
    # file - Full path String filename.
    #
    # Returns a Nokogiri::HTML document.
    def self.open_fragment file
      string = IO.read file
      Nokogiri::HTML.fragment string
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
      elsif file.haml_ext?
        Haml::Engine.new(string, :format => :xhtml).render
      else
        string
      end
    end

    # Public: Open a file as a string, taking care of fragment tags.
    # All fragment tags are replaced by a new content.
    #
    # file - Full path String name of a (html|markdown|haml) file.
    #
    # Returns a String.
    def self.build_page_content(file, working_dir)
      # TODO éviter le working_dir
      str = IO.read(file)
      if file.markdown_ext?
        BlueCloth.new(str).to_html
      elsif file.haml_ext?
        Haml::Engine.new(str, :format => :xhtml).render
      else
        Fragment.new(file, working_dir).to_html
      end
    end

    # Public: Get the list of <genit> tag in a document.
    #
    # file - Nokogiri::HTML or Nokogiri::XML document.
    #
    # Returns Nokogiri::XML::NodeSet.
    def self.genit_tags_from file
      file.css "genit"
    end

  end

end
