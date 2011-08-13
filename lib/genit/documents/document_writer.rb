# -*- encoding: utf-8 -*-

require 'fileutils'

module Genit

  # Write an html or xml document.
  class DocumentWriter
  
    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    def initialize working_dir
      @working_dir = working_dir
    end
    
    # Save the document as an xhtml file.
    #
    # document - A Nokogiri::HTML or Nokogiri::XML document
    # filename - The String name of the future saved document
    def save_as_xhtml document, filename
      @document = document
      remove_remaining_tags
      FileWriter.write document.to_xhtml, get_full_path(filename.force_html_extension)
    end
    
    private
    
    def remove_remaining_tags
      tags = @document.css 'genit'
      tags.each {|tag| tag.remove}
    end
    
    def get_full_path filename
      File.join(@working_dir, 'www', filename)
    end
    
  end
  
end
