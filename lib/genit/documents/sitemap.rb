# -*- encoding: utf-8 -*-

module Genit

  class Sitemap
  
    def initialize array
      @builder = Nokogiri::XML::Builder.new do |xml|
        xml.urlset('xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9') do
          array.each do |elem|
            xml.url do
              xml.loc elem
            end
          end
        end
      end
    end
  
    def build
      @builder.to_xml
    end
    
  end
  
end
