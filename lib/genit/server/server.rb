# -*- encoding: utf-8 -*-

require 'webrick'

module Genit

  # I use WEBrick to serve the html from the root directory.
  class Server

    # Public: Constructor.
    #
    # wd - The String working directory, where live the project.
    def initialize wd
      @server = WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => wd)
      ['INT', 'TERM'].each {|signal| trap_this signal }
    end

    # Start the web server.
    #
    # Returns nothing.
    def start
      puts "Press Ctrl-C to close."
      @server.start
    end

    private

      def trap_this signal
         trap(signal) { @server.shutdown } 
      end
  end

end
