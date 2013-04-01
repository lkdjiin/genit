# -*- encoding: utf-8 -*-

require 'sass'

module Genit

  # Render css from sass in the styles directory.
  class Css

    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    def initialize working_dir
      @working_dir = working_dir
    end

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

      def render_sass type
        template = File.open(@filename).read
        css = Sass::Engine.new(template, syntax: type).render
        @filename.gsub!(/(sass|scss)$/, 'css')
        File.open(@filename, "w") do |out|
          out.puts css
        end
      end
  end
end

