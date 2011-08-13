# -*- encoding: utf-8 -*-

require 'uri'

module Genit

  # Modify links.
  class BodyLinkBuilder < BuilderBase
  
    # Public: Build the menu of a particular page.
    #
    # page_name - The string filename of the page to build menu for.
    #
    # Returns the modified Nokogiri::XML::Document
    def build_for_page page_name
      build page_name, get_links
    end
    
    private
    
    def get_links
      @document.css("body a")
    end
    
    def update link
      @path = link['href']
      return if @path =~ URI::regexp
      nb = BuilderBase::get_number_of_base_dirs @page_name
      make_relative nb
      link['href'] = @path
    end
  
  end
  
end
