# -*- encoding: utf-8 -*-
require 'genit/extensions'
require 'genit/project'
require 'genit/documents'
require 'genit/utils'
require 'genit/builders'
require 'genit/tags'

module Errors
  def error message
    puts "Error: #{message}"
    exit 1
  end
end
  
module Genit
  include Errors
  
end
