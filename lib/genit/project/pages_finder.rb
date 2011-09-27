# -*- encoding: utf-8 -*-

module Genit

  # I can find the list of all page names, named from
  # the site root.
  class PagesFinder
  
    # Public: Constructor.
    #
    # working_dir - The String working directory, where live the project.
    def initialize working_dir
      @working_dir = working_dir
      @pages_folder = File.join(@working_dir, 'pages')
    end
  
    # Public: Retrieve the list of all page names.
    #
    # Returns an Array of String.
    def find
      list = Dir.glob(File.join(@pages_folder, '**/*'))
      list.map! { |name| name.gsub(@pages_folder + '/', '')}
      list.map { |name| name.force_html_extension }
    end
    
    def self.pagenames2urls array, url_string
      array.map { |name| File.join(url_string, name) }
    end
    
  end
  
end
