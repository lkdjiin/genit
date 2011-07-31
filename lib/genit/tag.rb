# -*- encoding: utf-8 -*-

module Genit

  # Base class for all Tags.
  class Tag
  
    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    # template    - The Nokogiri::XML::Document into which we process the tag.
    # filename    - The String name of the page
    # tag         - The tag to process as a Nokogiri::XML::Element
    def initialize working_dir, template, filename, tag
      @working_dir = working_dir
      @filename = filename
      @template = template
      @tag = tag
    end
    
    # Public: Replace a tag by a string content into the template.
    # This method not only returns the modified template, it also really replace
    # the template in place.
    #
    # css_rule - The String css rule to identify the tag to replace.
    # string   - The String replacement.
    #
    # Returns the template as a Nokogiri::XML::Document
    def replace_tag_into_template! css_rule, string
      builder = Builder.new(@template)
      @template = builder.replace(css_rule, string)
    end
  
  end

end
