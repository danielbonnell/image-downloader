# ImageDownloader

ImageDownloader is a simple gem for bulk-downloading images. It accepts the file_path of a .txt file containing whitespace-seperated image URLs and then attempts to download each image. If it fails to download an image, it logs the errors that were raised.

## Installation

Add the gem to an existing Ruby application:

    $ gem 'image-downloader', git: 'git://github.com/danielbonnell/image-downloader.git'

Using the gem from the command line:

    $ gem install image-downloader -s https://github.com/danielbonnell/

## Usage

If using from the command line:

    $ rake exec['path/to/file.txt']

If using within a Ruby application:

    $ ImageDownloader::Client.new(file_path: 'path/to/file.txt').call

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/danielbonnell/image-downloader.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
