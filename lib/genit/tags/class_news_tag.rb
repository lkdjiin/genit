# -*- encoding: utf-8 -*-

module Genit

  # Replace the <genit class="news"/> in the template.
  class ClassNewsTag < Tag
  
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
      replace_tag_into_template! 'genit.news', news_content
    end

    private

      def news_content
        news_string = ''
        news_files.each { |file| news_string += process_the_news(file) }
        news_string
      end

      def news_files
        files = Dir.glob(File.join(@working_dir, NEWS_DIR, '*')).sort.reverse
        number = @tag['number']
        return files[0...(number).to_i] if number
        files
      end

      def process_the_news file 
        doc_as_string = HtmlDocument.open_as_string(file).to_s
        wrapper = @tag['wrapper']
        return "<div class='#{wrapper}'>" + doc_as_string + '</div>' if wrapper
        doc_as_string
      end

  end

end
