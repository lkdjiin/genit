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
      check_missing_file '.genit', 'Not a genit project folder'
      check_missing_file 'config', 'Missing config file'
    end
  
    # Public: Compile the web site.
    def compile
      remove_content_of_www
      compile_site
    end
    
    private
    
    def check_missing_file filename, message
      unless File.exist?(File.join(@working_dir, filename))
        error message
      end
    end
    
    def remove_content_of_www
      Dir.foreach(File.join(@working_dir, 'www')) do |file|
        next if (file == ".") or (file == "..")
        filename = File.join(@working_dir, 'www', file)
        FileUtils.remove_dir(filename) if File.directory?(filename)
        FileUtils.remove_file(filename) if File.file?(filename)
      end
    end
    
    def compile_site
      compile_pages
      copy_static_content
      create_rss_feed
      create_sitemap_xml
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
    
    def copy_static_content
      destination = File.join(@working_dir, 'www')
      FileUtils.cp_r File.join(@working_dir, 'styles'), destination
      FileUtils.cp_r File.join(@working_dir, 'public'), destination
      FileUtils.cp_r File.join(@working_dir, 'scripts'), destination
    end
    
    def create_rss_feed
      all_news_files =
        Dir.glob(File.join(@working_dir, 'news', '*')).sort.reverse
      begin
        config_file = YAML.load_file(File.join(@working_dir, 'config'))
      rescue ArgumentError => msg
        error "In config file: #{msg}"
      rescue Exception => msg
        error "In config file: #{msg}"
      end
      return unless config_file[:rss]
      RssFeed.new(@working_dir, all_news_files, config_file).generate_rss
    end
    
    def create_sitemap_xml
      pages = PagesFinder.new(@working_dir).find
      config_file = YAML.load_file(File.join(@working_dir, 'config'))
      urls = PagesFinder.pagenames2urls(pages, config_file[:address])
      sitemap = Sitemap.new(urls).get
      FileWriter.write sitemap, File.join(@working_dir, 'www', 'sitemap.xml')
    end
    
  end
  
end
