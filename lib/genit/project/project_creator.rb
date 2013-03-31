# -*- encoding: utf-8 -*-

require "fileutils"
require "yaml"

module Genit

  # Create a skeleton project.
  class ProjectCreator

    # Sole constructor.
    #
    # name    - The String name of the future project folder.
    # empty   - A Boolean telling if we produce a smoke test or not.
    # haml    - A Boolean telling if we want project's files in haml or
    #           not.
    def initialize name, empty, haml
      @project_name = name
      @empty = empty
      @haml = haml
    end

    # Public: Create the structure of the project, that is many
    # files and folders.
    #
    # Returns nothing.
    def create
      begin
        create_the_project
      rescue SystemCallError
        puts "Cannot create project..."
      end
    end

    private

      def create_the_project
        create_the_project_folders
        copy_the_project_files
        create_the_project_config
      end

      def create_the_project_folders
        FileUtils.makedirs @project_name
        create_subfolders ['src', 'src/fragments', 'src/news', 'src/pages',
                           'scripts', 'styles', 'src/templates', 
                           'styles/images', 'public']
      end

      # Create some subfolders inside the project folder.
      #
      # a_array - An Array of String subfolder names
      #
      # Examples
      #
      #   create_subfolders ['styles', 'scripts']
      #
      #   create_subfolders ['styles/css/alsa', 'styles/css/yui',
      #                      'styles/css/images']
      #
      # Returns nothing.
      def create_subfolders a_array
        a_array.each {|dir| FileUtils.makedirs File.join(@project_name, dir) }
      end

      def copy_the_project_files
        copy_main_template
        copy_menu_template
        copy_files ['styles/handheld.css', 'styles/print.css']
        copy_index
        copy_screen_css
      end

      def create_the_project_config
        version =  File.read(File.join($GENIT_PATH, 'VERSION')).strip
        write_config version, '.genit'

        config_file = { :address => 'http://www.example.com',
                        :rss => true, 
                        :rss_title => 'RSS TITLE',
                        :rss_description => 'RSS DESCRIPTION'}.to_yaml
        write_config config_file, 'config'
      end

      def write_config content, filename
        dest =  File.join @project_name, filename
        File.open(dest, "w") {|out| out.puts content }
      end

      # Copy files to project.
      #
      # a_array - An Array of String "subfolder/file" names
      #
      # Example
      #
      #   copy_files ['templates/main.html', 'pages/index.html']
      #
      # Returns nothing.
      def copy_files a_array
        a_array.each do |file|
          src = File.join $GENIT_PATH, 'data', file
          dest =  File.join @project_name, file
          FileUtils.cp src, dest
        end
      end

      # TODO document
      def copy_index
        dest = index_destination
        src = index_source
        FileUtils.cp src, dest
      end

      def index_destination
        if @haml
          File.join @project_name, 'src/pages/index.haml'
        else
          File.join @project_name, 'src/pages/index.html'
        end
      end

      def index_source
        if @empty
          src = File.join $GENIT_PATH, 'data/pages/index2.'
        else
          src = File.join $GENIT_PATH, 'data/pages/index.'
        end
        if @haml
          "#{src}haml"
        else
          "#{src}html"
        end
      end

      # TODO document
      def copy_screen_css
        dest =  File.join @project_name, 'styles/screen.css'
        if @empty
          FileUtils.touch dest
        else
          src = File.join $GENIT_PATH, 'data/styles/screen.css'
          FileUtils.cp src, dest
        end
      end

      # TODO document
      def copy_main_template
        if @haml
          copy_main_template_haml
        else
          copy_main_template_html
        end
      end

      def copy_main_template_haml
        dest =  File.join @project_name, 'src/templates', 'main.haml'
        src = File.join $GENIT_PATH, 'data', 'templates', "html_5.haml"
        FileUtils.cp src, dest
      end

      def copy_main_template_html
        dest =  File.join @project_name, 'src/templates', 'main.html'
        copy_first_part dest
        ProjectCreator.append_last_part dest
      end

      def copy_menu_template
        if @haml
          dest =  File.join @project_name, 'src/templates', 'menu.haml'
          src = File.join $GENIT_PATH, 'data', 'templates', 'menu.haml'
        else
          dest =  File.join @project_name, 'src/templates', 'menu.html'
          src = File.join $GENIT_PATH, 'data', 'templates', 'menu.html'
        end
        FileUtils.cp src, dest
      end

      # TODO document
      def copy_first_part dest
        src = File.join $GENIT_PATH, 'data', 'templates', "html_5"
        FileUtils.cp src, dest
      end

      # TODO document
      def self.append_last_part dest
        src = File.join $GENIT_PATH, 'data', 'templates', 'main.html'
        content = File.open(src, "r").read
        File.open(dest, "a") {|out| out.puts content }
      end

  end

end
