# -*- encoding: utf-8 -*-

module Genit

  class ClassNewsTag < Tag
  
    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    # template    - The Nokogiri::XML::Document into which we process the tag.
    # filename    - The String name of the page
    # tag         - The tag to process as a Nokogiri::XML::Element
    def initialize working_dir, template, filename, tag
      super working_dir, template, filename, tag
    end
    
    # Public: Replace the <genit class="news"/> in the template.
    #
    # Returns the template as a Nokogiri::XML::Document
    def process
      replace_tag_into_template! 'genit.news', news_content
    end
    
    private
    
    def news_content
      news_files = Dir.glob(File.join(@working_dir, 'news', '*')).sort.reverse
      news_string = ''
      if @tag['number']
        news_files = news_files[0...(@tag['number']).to_i]
      end
      news_files.each do |file|
        doc = HtmlDocument.open_fragment file
        news_string += doc.to_s
      end
      
      news_string
    end
    
  end
  
end
