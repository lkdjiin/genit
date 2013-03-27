# -*- encoding: utf-8 -*-

module Genit

  # Replace each fragment in a page.
  class Fragment

    # Public: Constructor.
    #
    # file        - Full String filename of the page.
    # working_dir - The String working directory, where live the project.
    def initialize file, working_dir
      @page = HtmlDocument.open_fragment file
      @working_dir = working_dir
      HtmlDocument.genit_tags_from(@page).each do |tag|
        case tag['class']
          when 'fragment'
            @file = tag['file']
            error "Incomplete #{tag}" unless tag.key?('file')
            unless File.exists?(File.join(@working_dir, 'fragments', @file))
              error "No such file #{tag}"
            end
            replace_fragment 
        end
      end
    end

    # Public: Get the page in html format.
    #
    # Returns the html code of the page as a String.
    def to_html
      @page.to_html
    end

    private

      def replace_fragment
        builder = Builder.new(@page)
        @page = builder.replace(css_rule, content)
      end

      def css_rule
        "genit.fragment[file='#{@file}']"
      end

      def content
        full_path = File.join(@working_dir, 'fragments', @file)
        HtmlDocument.open_as_string(full_path)
      end

  end

end
