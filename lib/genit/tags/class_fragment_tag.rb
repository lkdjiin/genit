# -*- encoding: utf-8 -*-

module Genit

  # Replace the <genit class="fragment"/> in the template.
  class ClassFragmentTag < Tag
  
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
      file = @tag['file']
      fragment = HtmlDocument.build_page_content(File.join(@working_dir, 'fragments', file), @working_dir)
      css_rule = "genit.fragment[file='#{file}']"
      replace_tag_into_template! css_rule, fragment.to_s
    end
    
  end
  
end
