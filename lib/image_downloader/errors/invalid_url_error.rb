# frozen_string_literal: true

module ImageDownloader
  module Errors
    # This error is raised when a URL does not appear to be in a valid format
    class InvalidUrlError < Error
    end
  end
end
