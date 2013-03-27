# -*- encoding: utf-8 -*-

module Genit

  # Replace the <genit class="pages"/> in the template.
  class ClassPagesTag < Tag
  
    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    # template    - The Nokogiri::XML::Document into which we process the tag.
    # filename    - The String name of the page
    # tag         - The tag to process as a Nokogiri::XML::Element
    def initialize working_dir, template, filename, tag
      super working_dir, template, filename, tag
    end
    
    # Public: Do the replacement.
    #
    # Returns the template as a Nokogiri::XML::Document
    def process
      replace_tag_into_template! 'genit.pages', page_content
    end
    
    private
    
    def page_content
      filename = File.join(@working_dir, PAGES_DIR, @filename)
      HtmlDocument.build_page_content filename, @working_dir
    end
    
  end
  
end
