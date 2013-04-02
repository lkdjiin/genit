# -*- encoding: utf-8 -*-

require 'sass'

module Genit

  # Deals with the styles directory.
  class Css

    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    def initialize working_dir
      @working_dir = working_dir
    end

    # Public: Render css in the styles directory.
    #
    # Returns nothing.
    def render
      Dir.glob(File.join(@working_dir, STYLES_DIR, '**/*')) do |filename|
        @filename = filename
        if @filename.end_with?(".sass")
          render_sass :sass
        elsif @filename.end_with?(".scss")
          render_sass :scss
        end
      end
    end

    private

      # Render css from sass in the styles directory.
      # 
      # type - A Symbol for the sass syntax, either :sass or :scss.
      #
      # Returns nothing.
      def render_sass type
        template = File.open(@filename).read
        begin
          css = Sass::Engine.new(template, syntax: type).render
        rescue Exception => ex
          error "In #{@filename}\n  #{ex}"
        end
        @filename.gsub!(/(sass|scss)$/, 'css')
        File.open(@filename, "w") {|out| out.puts css }
      end
  end
end

