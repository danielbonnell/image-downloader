# frozen_string_literal: true

module ImageDownloader
  module Errors
    # This error is raised when an HTTP call to a URL returns anything other than a 200-level
    # response code.
    class InvalidResponseCodeError < Error
    end
  end
end
