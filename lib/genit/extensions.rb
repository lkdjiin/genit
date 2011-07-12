# -*- encoding: utf-8 -*-

class String

  def force_html_extension
    self.gsub /markdown$/, 'html'
  end
  
  def force_html_extension!
    self.gsub! /markdown$/, 'html'
  end
  
end
