# -*- encoding: utf-8 -*-

module Genit

  # Modify img src.
  class ImgBuilder < Relativizer
  
    # Public: Relativize image source.
    #
    # page_name - The string filename of the page.
    #
    # Returns the modified Nokogiri::XML::Document
    def build_for_page page_name
      build page_name, @document.css("body img")
    end
    
    private
    
    def update link
      super link, "src"
    end
  
  end
  
end
