# -*- encoding: utf-8 -*-

module Genit

  # A Genit general tag.
  # Currently we have two tags:
  #   * <genit class="pages"/>
  #   * <genit class="menu"/>
  class ClassTag < Tag
  
    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    # template    - The Nokogiri::XML::Document into which we process the tag.
    # filename    - The String name of the page
    # tag         - The tag to process as a Nokogiri::XML::Element
    def initialize working_dir, template, filename, tag
      super working_dir, template, filename, tag
    end
    
    # Public: Replace something in the template.
    #
    # Returns the template as a Nokogiri::XML::Document
    def process
      case @tag['class']
        when 'pages' then process_tag_pages
        when 'menu' then process_tag_menu
      end
    end
    
    private
    
    def process_tag_pages
      replace_tag_into_template! 'genit.pages', page_content
    end
    
    def page_content
      filename = File.join(@working_dir, 'pages', @filename)
      HtmlDocument.build_page_content filename, @working_dir
    end
    
    def process_tag_menu
      build_menu
      replace_tag_into_template! 'genit.menu', @menu.to_html
    end
    
    def build_menu
      menu = XmlDocument.open(File.join(@working_dir, "templates/menu.html"))
      builder = MenuBuilder.new(menu)
      @menu = builder.build_for_page(@filename)
    end
    
  end

end
