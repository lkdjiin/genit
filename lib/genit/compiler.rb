# -*- encoding: utf-8 -*-

require 'fileutils'

module Genit

  # Build the web site.
  class Compiler
  
    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    def initialize working_dir
      @working_dir = working_dir
    end
  
    # Public: Build the web site.
    def compile
      process_pages
      FileUtils.cp_r File.join(@working_dir, 'styles'), File.join(@working_dir, 'www')
    end
    
    private
    
    def process_pages
      Dir.foreach(File.join(@working_dir, 'pages')) do |file|
        next if (file == ".") or (file == "..")
        process file
      end
    end
    
    def process file
      load_files file
      build_file
      write_file file
    end
    
    def load_files file
      @template = HtmlDocument.open(File.join(@working_dir, 'templates/main.html'))
      @page_content = HtmlDocument.open_as_string(File.join(@working_dir, 'pages', file))
    end
    
    def build_file
      builder = Builder.new(@template)
      @template = builder.replace('genit.pages', @page_content)
    end
    
    def write_file file
      file.gsub! /\.markdown$/, '.html'
      File.open(File.join(@working_dir, 'www', file), "w") do |out| 
        out.puts @template.to_html
      end
    end
    
  end
  
end
