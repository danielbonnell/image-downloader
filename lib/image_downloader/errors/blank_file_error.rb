# frozen_string_literal: true

module ImageDownloader
  module Errors
    # This error is raised when an instance of ImageDownloader::Client is instantiated with a
    # blank txt file.
    class BlankFileError < Error
    end
  end
end
