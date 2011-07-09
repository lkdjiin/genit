# -*- encoding: utf-8 -*-

require 'nokogiri'
require 'bluecloth'

module Genit

  
  class Fragment
  
    def initialize file, working_dir
      @page = XmlDocument.open file
      @working_dir = working_dir
      HtmlDocument.genit_tags_from(@page).each do |tag|
        case tag['class']
          when 'fragment'
            @file = tag['file']
            replace_fragment 
        end
      end
    end
    
    def to_html
      @page.to_html
    end
    
    private
    
    def replace_fragment
      builder = Builder.new(@page)
      @page = builder.replace(css_rule, content)
    end
    
    def css_rule
      "genit.fragment[file='#{@file}']"
    end
    
    def content
      full_path = File.join(@working_dir, 'fragments', @file)
      HtmlDocument.open_as_string(full_path)
    end
    
  end
  
end
