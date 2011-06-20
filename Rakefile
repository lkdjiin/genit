# -*- encoding: utf-8 -*-

require 'rake'
require 'rspec/core/rake_task'

desc 'Test genit'
task :default => :spec

desc 'Test genit with rspec'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--color']
end

desc 'Check for code smells'
task :reek do
  puts 'Checking for code smells...'
  files = Dir.glob 'lib/**/*.rb'
  # files.delete FILE_TO_EXCLUDE
  args = files.join(' ')
  sh "reek --quiet #{args} | ./reek.sed"
end

desc 'Build genit & install it'
task :install do
  sh "gem build genit.gemspec"
	f = FileList['genit*gem'].to_a
	sh "gem install #{f.first} --no-rdoc --no-ri"
end

desc 'Generate yard documentation for developpers'
task :doc do 
	exec 'yardoc --title "genit Documentation" - NEWS VERSION'
end
