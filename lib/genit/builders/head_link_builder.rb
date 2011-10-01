# -*- encoding: utf-8 -*-

module Genit

  # Modify head link tags.
  class HeadLinkBuilder < Relativizer
    
    # Public: Build the document head link tags of a particular page.
    #
    # page_name - The string filename of the page.
    #
    # Returns the modified Nokogiri::XML::Document
    def build_for_page page_name
      build page_name, @document.css("head link")
    end
    
    private
    
    def update link
      super link, "href"
    end
    
  end
  
end
