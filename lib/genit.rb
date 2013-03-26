# -*- encoding: utf-8 -*-
require 'genit/extensions'
require 'genit/project'
require 'genit/documents'
require 'genit/utils'
require 'genit/builders'
require 'genit/tags'
require 'genit/server'

module Errors

  def error message
    puts "Error: #{message}"
    exit 1
  end
  
  def warning message
    puts "Warning: #{message}"
  end
  
end
  
module Genit
  include Errors
  
end
