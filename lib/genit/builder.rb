# -*- encoding: utf-8 -*-

require 'nokogiri'

module Genit

  # Build a document from various sources.
  class Builder
  
    # Public: Constructor.
    #
    # document - A Nokogiri::HTML | Nokogiri::XML document
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
    # Return the changed document.
    def replace css_rule, replacement
      tag = @document.at_css(css_rule)
      tag.replace replacement
      @document
    end
    
    def select_menu page
      tags = @document.css("ul#menu a")
      tags.each {|tag|
        if tag['href'] == page
          tag['id'] = 'selected'
          break
        end
      }
      @document
    end
    
  end
  
end
