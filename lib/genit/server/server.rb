# -*- encoding: utf-8 -*-

require 'webrick'

module Genit

  class Server

    def initialize wd
      www = File.join(wd, "www")
      @server = WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => www)
      ['INT', 'TERM'].each do |signal|
         trap(signal){ @server.shutdown} 
      end
    end

    def run
      puts "Press Ctrl-C to close."
      @server.start
    end
  end

end
