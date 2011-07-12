# -*- encoding: utf-8 -*-

require 'fileutils'

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
      @template = HtmlDocument.open(File.join(@working_dir, 'templates/main.html'))
    end
    
    # Public: Compile the page.
    #
    # Returns a Nokogiri::HTML document.
    def compile
      genit_tags = HtmlDocument.genit_tags_from @template
      genit_tags.each {|tag| process_tag tag }
      @template
    end
    
    private
    
    def process_tag tag
      case tag['class']
        when 'pages' then tag_pages
        when 'menu' then tag_menu
      end
    end
    
    # Remplace la page au sein du template
    def tag_pages
      builder = Builder.new(@template)
      @template = builder.replace('genit.pages', page_content)
    end
    
    def page_content
      filename = File.join(@working_dir, 'pages', @filename)
      HtmlDocument.build_page_content filename, @working_dir
    end
    
    def tag_menu
      build_menu
      replace_menu_into_template
    end
    
    def build_menu
      menu = XmlDocument.open(File.join(@working_dir, "templates/menu.html"))
      builder = Builder.new(menu)
      @menu = builder.select_menu(@filename)
    end
    
    def replace_menu_into_template
      builder = Builder.new(@template)
      @template = builder.replace('genit.menu', @menu.to_html)
    end
  
  end
  
end
