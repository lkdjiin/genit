# -*- encoding: utf-8 -*-

module Genit

  # Compile a single page.
  class PageCompiler
  
    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    # filename    - The String name of the page
    def initialize working_dir, filename
      @working_dir = working_dir
      @filename = filename
      @template = XmlDocument.open(File.join(@working_dir, 'templates/main.html'))
    end
    
    # Public: Compile the page.
    #
    # Returns a Nokogiri::XML document.
    def compile
      compile_body
      compile_head
    end
    
    private
    
    def compile_body
      genit_tags_in_template.each do |tag| 
        tp = TagProcessor.new(@working_dir, @template, @filename, tag)
        @template = tp.process
      end
      builder = BodyLinkBuilder.new @template
      @template = builder.build_for_page @filename
    end
    
    def compile_head
      builder = HeadLinkBuilder.new @template
      builder.build_for_page @filename
    end
    
    # Returns all <genit> tags found in the template.
    def genit_tags_in_template
      HtmlDocument.genit_tags_from @template
    end
  
  end
  
end
