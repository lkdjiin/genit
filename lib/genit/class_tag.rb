# -*- encoding: utf-8 -*-

module Genit

  # A Genit general tag.
  # Currently we have three tags:
  #   * <genit class="pages"/>
  #   * <genit class="menu"/>
  #   * <genit class="fragment" file="foo.html"/>
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
        when 'fragment' then process_fragment
        else
          raise RuntimeError
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
    
    def process_fragment
      file = @tag['file']
      fragment = HtmlDocument.build_page_content(File.join(@working_dir, 'fragments', file), @working_dir)
      css_rule = "genit.fragment[file='#{file}']"
      replace_tag_into_template! css_rule, fragment.to_s
    end
    
  end

end
