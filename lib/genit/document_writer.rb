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
      filename.gsub! /\.markdown$/, '.html'
      File.open(File.join(@working_dir, 'www', filename), "w") do |out| 
        out.puts document.to_html
      end
    end
    
  end
  
end
