# -*- encoding: utf-8 -*-

require 'fileutils'

module Genit

  # Write a file on disk.
  class FileWriter
    
    def self.write content, full_path
      create_dirs full_path
      File.open(full_path, "w") {|out| out.puts content }
    end
    
    private
    
    def self.create_dirs full_path
      dir = File.dirname full_path
      FileUtils.makedirs(dir) unless File.directory?(dir)
    end
    
  end
  
end
