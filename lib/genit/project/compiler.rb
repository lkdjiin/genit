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
      if genit_project_folder?
        compile_site
      else
        puts 'Not a genit project folder'
      end
    end
    
    private
    
    def genit_project_folder?
      File.exist?(File.join(@working_dir, '.genit'))
    end
    
    def compile_site
      compile_pages
      FileUtils.cp_r File.join(@working_dir, 'styles'), File.join(@working_dir, 'www')
      FileUtils.cp_r File.join(@working_dir, 'public'), File.join(@working_dir, 'www')
      FileUtils.cp_r File.join(@working_dir, 'scripts'), File.join(@working_dir, 'www')
    end
    
    def compile_pages
      Dir.glob(File.join(@working_dir, 'pages', '**/*')) do |file|
        next if File.directory?(file)
        @filename = file.gsub(File.join(@working_dir, 'pages') + '/', '')
        compile_page
      end
    end
    
    def compile_page
      pc = PageCompiler.new @working_dir, @filename
      @page = pc.compile
      save_file_as_xhtml
    end
    
    def save_file_as_xhtml
      doc_writer = DocumentWriter.new @working_dir
      doc_writer.save_as_xhtml @page, @filename
    end
    
  end
  
end
