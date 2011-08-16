# -*- encoding: utf-8 -*-

module Genit

  # A Genit tag that represents a variable.
  # For example, in the template you have: <genit var="page_title"/>,
  # and in the page you have: <genit var="page_title">My Title</genit>.
  class HereTag < Tag
  
    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    # template    - The Nokogiri::XML::Document into which we process the tag.
    # filename    - The String name of the page
    # tag         - The tag to process as a Nokogiri::XML::Element
    def initialize working_dir, template, filename, tag
      super working_dir, template, filename, tag
    end
    
    # Public: Replace a variable in the template. The variable content is found
    # in the tag in the page.
    #
    # Returns the template as a Nokogiri::XML::Document
    def process
      replace_tag_into_template! get_css_rule, get_variable_value
      @template
    end
    
    private
    
    def get_css_rule
      var_name = @tag['here']
      "genit[here='#{var_name}']"
    end
    
    def get_variable_value
      filename = File.join(@working_dir, 'pages', @filename)
      doc = HtmlDocument.open_fragment filename
      elem = doc.at_css("genit[what='#{@tag['here']}']")
      if elem.nil?
        ""
      else
        elem.inner_html
      end
    end
    
  end

end
