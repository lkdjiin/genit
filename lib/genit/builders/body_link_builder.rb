# -*- encoding: utf-8 -*-

module Genit

  # Modify links.
  class BodyLinkBuilder < Relativizer
  
    # Public: Relativize links.
    #
    # page_name - The string filename of the page.
    #
    # Returns the modified Nokogiri::XML::Document
    def build_for_page page_name
      build page_name, @document.css("body a")
    end
    
    private
    
    def update link
      super link, "href"
    end
  
  end
  
end
