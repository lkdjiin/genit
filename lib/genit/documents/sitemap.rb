# -*- encoding: utf-8 -*-

module Genit

  # Build an XML sitemap.
  class Sitemap
  
    # Public: Constructor.
    #
    # urls - an Array of all the URLs to include in the sitemap.
    def initialize urls
      @builder = Nokogiri::XML::Builder.new do |xml|
        xml.urlset('xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9') do
          urls.each do |elem|
            xml.url do
              xml.loc elem
            end
          end
        end
      end
    end
  
    # Public: Get the sitemap
    #
    # Returns
    def get
      @builder.to_xml
    end
    
  end
  
end
