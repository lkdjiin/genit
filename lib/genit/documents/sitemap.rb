# -*- encoding: utf-8 -*-

module Genit

  # Build an XML sitemap.
  class Sitemap
  
    # Public: Constructor.
    #
    # urls - an Array of all the URLs to include in the sitemap.
    def initialize urls
      @builder = Sitemap.builder urls
    end
  
    # Public: Get the sitemap
    #
    # Returns the sitemap as a String.
    def get
      @builder.to_xml
    end
    
    private
    
    def self.builder urls
      Nokogiri::XML::Builder.new { |xml| Sitemap.build_urlset xml, urls }
    end
    
    def self.build_urlset xml, urls
      xml.urlset('xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9') do
        Sitemap.build_url_elements xml, urls
      end
    end
    
    def self.build_url_elements xml, urls
      urls.each { |elem| Sitemap.build_loc_element xml, elem }
    end
    
    def self.build_loc_element xml, elem
      xml.url { xml.loc elem }
    end
    
  end
  
end
