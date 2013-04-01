# -*- encoding: utf-8 -*-
require 'genit/extensions'
require 'genit/project'
require 'genit/documents'
require 'genit/utils'
require 'genit/builders'
require 'genit/tags'
require 'genit/server'

require 'sass'

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

  PAGES_DIR = "src/pages"
  TEMPLATES_DIR = "src/templates"
  FRAGMENTS_DIR = "src/fragments"
  NEWS_DIR = "src/news"
  STYLES_DIR = "styles"
end
