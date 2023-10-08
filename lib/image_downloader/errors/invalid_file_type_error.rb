# frozen_string_literal: true

module ImageDownloader
  module Errors
    # This error is raised when the detected MIME type from a given URL is not an image
    class InvalidFileTypeError < Error
    end
  end
end
