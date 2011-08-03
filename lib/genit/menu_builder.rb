# -*- encoding: utf-8 -*-

require 'uri'

module Genit

  # Modify menu links.
  class MenuBuilder
  
    # Public: Constructor.
    #
    # menu - A Nokogiri::XML::Document
    def initialize menu
      @document = menu
    end
    
    # Public: Build the menu of a particular page.
    #
    # page_name - The string filename of the page to build menu for.
    #
    # Returns the modified Nokogiri::XML::Document
    def build_for_page page_name
      @page_name = page_name
      menu_links.each {|link| update_link link }
      @document
    end
    
    def self.get_number_of_base_dirs filename
      return 0 if filename =~ URI::regexp
      
      dirs = File.dirname filename
      return 0 if dirs == '.'
      
      return dirs.split('/').size
    end
    
    private
    
    def menu_links
      @document.css("ul#menu a")
    end
    
    def update_link link
      @path = link['href']
      link['id'] = 'selected' if @path == @page_name.force_html_extension
      nb = MenuBuilder::get_number_of_base_dirs @page_name
      make_relative nb
      link['href'] = @path
    end
    
    def make_relative nb
      nb.times { @path = '../' + @path }
    end
  
  end
  
end
