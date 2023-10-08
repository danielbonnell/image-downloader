# frozen_string_literal: true

require_relative 'lib/image_downloader/version'

Gem::Specification.new do |spec|
  spec.name    = 'image-downloader'
  spec.version = ImageDownloader::VERSION
  spec.authors = ['Daniel Bonnell']
  spec.email   = ['daniel.bonnell@gmail.com']

  spec.summary               = 'Simple command-line tool to download images from a list of URLs'
  spec.homepage              = 'https://github.com/danielbonnell/image-downloader'
  spec.license               = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri']   = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.executables << 'exec'
end
