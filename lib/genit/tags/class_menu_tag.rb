# -*- encoding: utf-8 -*-

module Genit

  # Replace the <genit class="menu"/> in the template.
  class ClassMenuTag < Tag
  
    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    # template    - The Nokogiri::XML::Document into which we process the tag.
    # filename    - The String name of the page
    # tag         - The tag to process as a Nokogiri::XML::Element
    def initialize working_dir, template, filename, tag
      super working_dir, template, filename, tag
    end
    
    # Public: Do the replacement.
    #
    # Returns the template as a Nokogiri::XML::Document
    def process
      build_menu
      replace_tag_into_template! 'genit.menu', @menu.to_html
    end
    
    private
    
    def build_menu
      file = File.join(@working_dir, TEMPLATES_DIR, "menu.html")
      menu = XmlDocument.open(file)
      builder = MenuBuilder.new(menu)
      @menu = builder.build_for_page(@filename)
    end
    
  end
  
end
