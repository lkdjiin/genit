# -*- encoding: utf-8 -*-

require 'fileutils'

module Genit

  # My responsability is to clean the root directory before a
  # compilation. I have to keep alive some files (.genit, config) and
  # some folders (src/, public/, etc).
  class RootCleaner

    # Public: Constructor.
    #
    # wd - The String working directory, where live the project.
    def initialize wd
      @wd = wd
    end

    # Public: Clean the root directory.
    #
    # Returns nothing.
    def clean
      Dir.foreach(@wd) do |file|
        next if file.start_with?('.') or (file == "config")
        filename = File.join(@wd, file)
        FileUtils.remove_file(filename) if File.file?(filename)
      end
    end
  end

end
