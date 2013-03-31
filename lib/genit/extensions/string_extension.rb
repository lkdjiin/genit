# -*- encoding: utf-8 -*-

class String

  def force_html_extension
    self.gsub /(markdown|haml)$/, 'html'
  end
  
  def force_html_extension!
    self.gsub! /(markdown|haml)$/, 'html'
  end
  
  def markdown_ext?
    self.end_with?('.markdown')
  end
  
  def haml_ext?
    self.end_with?('.haml')
  end
end
