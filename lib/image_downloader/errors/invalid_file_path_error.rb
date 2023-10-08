# frozen_string_literal: true

module ImageDownloader
  module Errors
    # This error is raised when an instance of ImageDownloader::Client is instantiated with an
    # invalid `file_path`.
    class InvalidFilePathError < Error
    end
  end
end
