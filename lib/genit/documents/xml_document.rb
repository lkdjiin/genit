# -*- encoding: utf-8 -*-

require 'nokogiri'
require 'bluecloth'
require 'haml'

module Genit

  # Open an xml file.
  class XmlDocument
  
    # Public: Open an xml document.
    #
    # file - Full path String filename.
    #
    # Returns a Nokogiri::XML document.
    def self.open file
      begin
        Nokogiri::XML(File.open(file)){|config| config.strict}
      rescue Nokogiri::XML::SyntaxError => ex
        error "Malformed xhtml in file #{file} : #{ex}"
      end
    end

    # Public: Open a (xml) document from a haml file.
    #
    # file - Full path String filename of haml file.
    #
    # Returns a Nokogiri::XML document.
    def self.open_via_haml file
      tmp = Haml::Engine.new(File.open(file).read, :format => :xhtml).render
      Nokogiri::XML(tmp) 
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
