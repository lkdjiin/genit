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
        @file = file
        compile_page
      end
    end
    
    def compile_page
      @template = HtmlDocument.open(File.join(@working_dir, 'templates/main.html'))
      genit_tags = HtmlDocument.genit_tags_from @template
      genit_tags.each {|tag| process_tag tag }
      save_file_as_html
    end
    
    def process_tag tag
      case tag['class']
        when 'pages' then tag_pages
        when 'menu' then tag_menu
      end
    end
    
    # Remplace la page au sein du template
    def tag_pages
      @page_content = HtmlDocument.open_as_string(File.join(@working_dir, 'pages', @file))
      builder = Builder.new(@template)
      @template = builder.replace('genit.pages', @page_content)
    end
    
    # Crée le menu ET le remplace au sein du template
    def tag_menu
      menu = Nokogiri::XML(File.open(File.join(@working_dir, "templates/menu.html"))) # XmlDocument
      builder = Builder.new(menu)
      menu = builder.select_menu(@file)
      builder = Builder.new(@template)
      @template = builder.replace('genit.menu', menu.to_html)
    end
    
    def save_file_as_html
      force_file_to_html
      write_file
    end
    
    def force_file_to_html
      @file.gsub! /\.markdown$/, '.html'
    end
    
    def write_file
      File.open(File.join(@working_dir, 'www', @file), "w") do |out| 
        out.puts @template.to_html
      end
    end
    
  end
  
end
