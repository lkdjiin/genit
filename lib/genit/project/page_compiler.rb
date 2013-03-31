# -*- encoding: utf-8 -*-

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
      # file = File.join(@working_dir, 'src/templates/main.html')
      # @template = XmlDocument.open(file)
      file = File.join(@working_dir, 'src/templates/main')
      if File.exists?("#{file}.html")
        file = file + ".html"
        @template = XmlDocument.open(file)
      elsif File.exists?("#{file}.haml")
        file = file + ".haml"
        @template = XmlDocument.open_via_haml(file)
      else
        error "No template found"
      end
    end

    # Public: Compile the page.
    #
    # Returns a Nokogiri::XML document.
    def compile
      compile_body
      compile_head
      
      builder = ScriptBuilder.new @template
      builder.build_for_page @filename
    end

    private

      def compile_body
        # Pourquoi 2 fois ?
        # Parce que la 1ere fois, on inclus essentiellement la page au sein du
        # template, et la seconde fois, on s'occupe des tags restants (ceux qui
        # étaient dans la page).
        # Suivant comment la hiérarchie de tag évoluera, il est possible qu'on
        # ai un jour besoin de faire une boucle du genre :
        # "Tant qu'il reste des tags"
        2.times { replace_all_genit_tags }
        build BodyLinkBuilder
        build ImgBuilder
      end

      def replace_all_genit_tags
        genit_tags_in_template.each do |tag| 
          next if tag.genit_what?
          tp = TagProcessor.new(@working_dir, @template, @filename, tag)
          @template = tp.process
        end
      end

      def build a_class
        @template = a_class.new(@template).build_for_page(@filename)
      end

      def compile_head
        builder = HeadLinkBuilder.new @template
        builder.build_for_page @filename
      end

      # Returns all <genit> tags found in the template.
      def genit_tags_in_template
        HtmlDocument.genit_tags_from @template
      end

  end

end
