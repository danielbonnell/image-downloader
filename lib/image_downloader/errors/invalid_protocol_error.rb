# frozen_string_literal: true

module ImageDownloader
  module Errors
    # This error is raised when the URL protocol is anything other than http or https.
    class InvalidProtocolError < Error
    end
  end
end
