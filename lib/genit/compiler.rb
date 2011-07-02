# -*- encoding: utf-8 -*-

require 'fileutils'

module Genit

  # Web site "compiler".
  class Compiler
  
    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    def initialize working_dir
      @working_dir = working_dir
    end
  
    # Public: Compile the web site.
    def compile
      compile_pages
      FileUtils.cp_r File.join(@working_dir, 'styles'), File.join(@working_dir, 'www')
    end
    
    private
    
    def compile_pages
      Dir.foreach(File.join(@working_dir, 'pages')) do |file|
        next if (file == ".") or (file == "..")
        @filename = file
        compile_page
      end
    end
    
    def compile_page
      pc = PageCompiler.new @working_dir, @filename
      @template = pc.compile
      save_file_as_html
    end
    
    def save_file_as_html
      doc_writer = DocumentWriter.new @working_dir
      doc_writer.save_as_html @template, @filename
    end
    
  end
  
end
