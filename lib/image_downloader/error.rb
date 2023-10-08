# frozen_string_literal: true

module ImageDownloader
  # Base class for internally raised errors.
  class Error < StandardError
    # Most errors will be raised when validating a URL or attempting to fetch the resource,
    # and therefore can be grouped under a single URL.
    def initialize(url: nil)
      @url = url

      super
    end

    attr_reader :url

    # Print error class name and URL to console. In the future, this could be extended to report
    # to a logger or 3rd party analytics tool (e.g. DataDog)
    def print
      puts "#{self.class.name}: #{url}"
    end
  end
end
