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
        @file = file
        process_file
      end
    end
    
    def process_file
      @template = HtmlDocument.open(File.join(@working_dir, 'templates/main.html'))
      genit_tags = HtmlDocument.genit_tags_from @template
      genit_tags.each {|tag| process_tag tag }
      write_file
    end
    
    def process_tag tag
      case tag['class']
        when 'pages' then tag_pages
        when 'menu' then tag_menu
      end
    end
    
    def tag_pages
      @page_content = HtmlDocument.open_as_string(File.join(@working_dir, 'pages', @file))
      builder = Builder.new(@template)
      @template = builder.replace('genit.pages', @page_content)
    end
    
    def tag_menu
      menu = Nokogiri::XML(File.open(File.join(@working_dir, "templates/menu.html")))
      builder = Builder.new(menu)
      menu = builder.select_menu(@file)
      builder = Builder.new(@template)
      @template = builder.replace('genit.menu', menu.to_html)
    end
    
    def write_file
      @file.gsub! /\.markdown$/, '.html'
      File.open(File.join(@working_dir, 'www', @file), "w") do |out| 
        out.puts @template.to_html
      end
    end
    
  end
  
end
