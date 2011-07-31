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
      @template = XmlDocument.open(File.join(@working_dir, 'templates/main.html'))
    end
    
    # Public: Compile the page.
    #
    # Returns a Nokogiri::XML document.
    def compile
      genit_tags_in_template.each {|tag| process_tag tag }
      @template
    end
    
    private
    
    # Returns all <genit> tags found in the template.
    def genit_tags_in_template
      HtmlDocument.genit_tags_from @template
    end
    
    def process_tag tag
      if tag['class']
        tag_class tag['class']
      elsif tag['var']
        tag_var tag['var']
      end
    end
    
    def tag_class tag_value
      case tag_value
        when 'pages' then process_tag_pages
        when 'menu' then process_tag_menu
      end
    end
    
    def tag_var tag_value
      filename = File.join(@working_dir, 'pages', @filename)
      doc = HtmlDocument.open filename
      value = doc.at_css("genit[var='#{tag_value}']").inner_html
      builder = Builder.new(@template)
      @template = builder.replace("genit[var='#{tag_value}']", value)
    end
    
    # Remplace la page au sein du template
    def process_tag_pages
      builder = Builder.new(@template)
      @template = builder.replace('genit.pages', page_content)
    end
    
    def page_content
      filename = File.join(@working_dir, 'pages', @filename)
      HtmlDocument.build_page_content filename, @working_dir
    end
    
    def process_tag_menu
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
