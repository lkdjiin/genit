# -*- encoding: utf-8 -*-

require 'nokogiri'

module Genit

  # Build a document from various sources.
  class Builder
  
    # Public: Constructor.
    #
    # document - A Nokogiri::HTML document
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
    # Return the changed Nokogiri::HTML document.
    def replace css_rule, replacement
      tag = @document.at_css(css_rule)
      tag.replace replacement
      @document
    end
    
  end
  
end
