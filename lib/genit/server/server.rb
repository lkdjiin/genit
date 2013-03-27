# -*- encoding: utf-8 -*-

require 'webrick'

module Genit

  class Server

    def initialize wd
      @server = WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => wd)
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
