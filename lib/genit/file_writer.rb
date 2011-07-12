# -*- encoding: utf-8 -*-

require 'fileutils'

module Genit

  # Write a file on disk.
  class FileWriter
    
    def self.write content, full_path
      File.open(full_path, "w") {|out| out.puts content }
    end
    
  end
  
end
