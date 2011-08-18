# -*- encoding: utf-8 -*-

module Genit

  # Modify script tags.
  class ScriptBuilder < BuilderBase
    
    # Public: Relativize the <script src=""> tags of a particular page.
    #
    # page_name - The string filename of the page.
    #
    # Returns the modified Nokogiri::XML::Document
    def build_for_page page_name
      build page_name, head_links
    end
    
    private
    
    def head_links
      @document.css("script")
    end
    
    def update link
      @path = link['src']
      return if not_an_internal_link?
      nb = BuilderBase::get_number_of_base_dirs @page_name
      make_relative nb
      link['src'] = @path
    end
    
    def not_an_internal_link?
      @path.nil? or @path =~ URI::regexp
    end
    
  end
  
end
