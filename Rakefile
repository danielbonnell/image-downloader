# frozen_string_literal: true

require_relative 'lib/image_downloader'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[spec rubocop]

# rake exec['path/to/file.txt']
task :exec, [:file_path] do |_task, args|
  if (file_path = args[:file_path]).nil?
    puts 'Must provide path to .txt file containing URLs'
  else
    ImageDownloader::Client.new(file_path:).call
  end
end
