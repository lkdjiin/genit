# -*- encoding: utf-8 -*-

require 'rake'

Gem::Specification.new do |s|
  s.name = 'genit'
  s.version = File.read('VERSION').strip
  s.authors = ['Xavier Nayrac']
  s.email = 'xavier.nayrac@gmail.com'
  s.summary = 'Static web site framework'
  s.homepage = 'https://github.com/lkdjiin/genit'
  s.description = %q{Genit builds a **static web site**, that is a web site without server side 
programing language and database. The site consists only of xhtml code (+ css and medias) and 
eventually of javascript. It is a command line framework, essentially based on conventions.
Genit is based on the idea that we don't have to learn any new languages to manage templates
because xml can do it well.
Genit is design to be simple, readable and minimalist.}
  
  readmes = FileList.new('*') do |list|
    list.exclude(/(^|[^.a-z])[a-z]+/)
    list.exclude('TODO')
  end.to_a
  s.files = FileList['lib/**/*.rb', 'bin/*', 'data/**/*', 'spec/**/*', '[A-Z]*'].to_a + readmes
  s.license = 'Expat (also known as MIT)'
  s.required_ruby_version = '>= 1.9.2'
  s.executables = ['genit']
  s.add_dependency 'nokogiri', '>= 1.4.6'
  s.add_dependency 'bluecloth', '>= 2.1.0'
  s.add_dependency 'clamp', '>= 0.2.2'
  s.add_dependency 'haml', '>= 4.0.1'

end
