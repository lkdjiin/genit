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
    
    # Save the document as an html file.
    #
    # document - A Nokogiri::HTML or Nokogiri::XML document
    # filename - The String name of the future saved document
    def save_as_html document, filename
      FileWriter.write document.to_html, get_full_path(filename.force_html_extension)
    end
    
    private
    
    def get_full_path filename
      File.join(@working_dir, 'www', filename)
    end
    
  end
  
end
