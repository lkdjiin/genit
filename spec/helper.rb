# -*- encoding: utf-8 -*-

require 'coco'

$GENIT_PATH = File.expand_path(File.join(File.expand_path(File.dirname(__FILE__)), '..'))

require './lib/genit'
include Genit

TEST_REPOSITORY = 'spec/project-name'

def clean_test_repository
  Dir.foreach(TEST_REPOSITORY) do |file|
    next if (file == ".") or (file == "..")
    filename = File.join(TEST_REPOSITORY, file)
    FileUtils.remove_dir(filename) if File.directory?(filename)
    FileUtils.remove_file(filename) if File.file?(filename)
  end
end

def test_project_path
  File.expand_path('spec/project-name')
end
