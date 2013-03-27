# -*- encoding: utf-8 -*-

require 'uri'

module Genit

  # A base class for all builders.
  class BuilderBase

    # Public: Constructor.
    #
    # doc - A Nokogiri::XML::Document
    def initialize doc
      raise RuntimeError if doc.nil?
      @document = doc
    end

    # Define me in child
    def build_for_page page_name
      raise NotImplementedError
    end

    def build page_name, elements
      @page_name = page_name
      elements.each {|elem| update elem }
      @document
    end

    def BuilderBase.get_number_of_base_dirs filename
      return 0 if filename =~ URI::regexp
      
      dirs = File.dirname filename
      return 0 if dirs == '.'
      
      return dirs.split('/').size
    end

    private

      def make_relative nb
        nb.times { @path = '../' + @path }
      end

  end

end
