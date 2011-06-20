# -*- encoding: utf-8 -*-

require 'rake'

Gem::Specification.new do |s|
  s.name = 'genit'
  s.version = File.read('VERSION').strip
  s.authors = ['Xavier Nayrac']
  s.email = 'xavier.nayrac@gmail.com'
  s.summary = 'Static web site framework'
  s.homepage = ''
  s.description = %q{Genit builds a **static web site**, that is a web site without server side 
programing language and database. The site consists only of xhtml code (+ css and medias) and 
eventually of javascript. It is a command line framework, essentially based on conventions.
Genit is design to be simple, reable and minimalist.}
	
	readmes = FileList.new('*') do |list|
		list.exclude(/(^|[^.a-z])[a-z]+/)
		list.exclude('TODO')
	end.to_a
  s.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*'].to_a + readmes
	s.license = 'Expat (also known as MIT)'
	s.required_ruby_version = '>= 1.9.2'
end
