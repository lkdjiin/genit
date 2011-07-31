# -*- encoding: utf-8 -*-

class String

  def force_html_extension
    self.gsub /markdown$/, 'html'
  end
  
  def force_html_extension!
    self.gsub! /markdown$/, 'html'
  end
  
  def markdown_ext?
    self.end_with?('.markdown')
  end
  
end

module Nokogiri
  module XML
  
    # I think it's a bad idea to extend the Nokogiri library cause it makes a
    # too big dependency on Genit.
    # It will be much better to do a little wrapper over Nokogiri::XML::Node.
    class Node
    
      def genit_class?
        if self['class']
          true
        else
          false
        end
      end
      
      def genit_var?
        if self['var']
          true
        else
          false
        end
      end
      
    end
  end
end
