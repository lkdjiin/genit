# -*- encoding: utf-8 -*-

module Genit

  # Replace a tag in a template.
  class TagProcessor
  
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
      if tag.genit_class?
        @tag = ClassTag.new(@working_dir, @template, @filename, tag)
      elsif tag.genit_var?
        @tag = VarTag.new(@working_dir, @template, @filename, tag)
      else
        raise RuntimeError
      end
    end
    
    # Returns the modified template as a Nokogiri::XML::Document
    def process
      @tag.process
    end
    
  end

end
