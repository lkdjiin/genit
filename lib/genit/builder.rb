# -*- encoding: utf-8 -*-

require 'nokogiri'

module Genit

  # Build a document from various sources.
  class Builder
  
    # Public: Constructor.
    #
    # document - A Nokogiri::XML::Document
    def initialize document
      @document = document
    end
    
    # Public: Replace a tag (and its children) from the current document by a 
    # string.
    #
    # css_rule    - The String css rule to find the tag
    # replacement - The replacement String
    #
    # Examples
    #
    #   doc = builder.replace('genit.pages', "<working />")
    #
    # Return the updated Nokogiri::XML::Document document.
    def replace css_rule, replacement
      tag = @document.at_css(css_rule)
      tag.replace replacement
      @document
    end
    
    # Public: Mark the <a> element of the menu that is selected (the displayed 
    # page).
    #
    # page_name - The String filename of the page
    #
    # Examples
    #
    #   menu = Nokogiri::XML(File.open('menu.html'))
    #   builder = Builder.new(menu)
    #   menu = builder.select_menu('index.html')
    #
    # Return the updated Nokogiri::XML::Document document.
    def select_menu page_name
      tags = @document.css("ul#menu a")
      tags.each {|tag|
        if tag['href'] == page_name.gsub(/\.markdown$/, '.html')
          tag['id'] = 'selected'
          break
        end
      }
      @document
    end
    
  end
  
end
