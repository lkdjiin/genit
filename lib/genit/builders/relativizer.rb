# -*- encoding: utf-8 -*-

require 'uri'

module Genit

  # Base class for builder that should relativize
  # some links in a XHTML document.
  class Relativizer < BuilderBase
  
    def not_an_internal_link?
      @path.nil? or @path =~ URI::regexp
    end
    
    private
    
    def update link, field
      @path = link[field]
      return if not_an_internal_link?
      nb = BuilderBase::get_number_of_base_dirs @page_name
      make_relative nb
      link[field] = @path
    end
    
  end
  
end
