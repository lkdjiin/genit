# -*- encoding: utf-8 -*-

require 'fileutils'

module Genit

  class RootCleaner

    def initialize wd
      @wd = wd
    end

    def clean
      Dir.foreach(@wd) do |file|
        next if file.start_with?('.') or (file == "config")
        filename = File.join(@wd, file)
        FileUtils.remove_file(filename) if File.file?(filename)
      end
    end
  end

end
