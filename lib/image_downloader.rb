# frozen_string_literal: true

require_relative 'image_downloader/version'
require_relative 'image_downloader/client'
require_relative 'image_downloader/error'
require_relative 'image_downloader/errors/blank_file_error'
require_relative 'image_downloader/errors/invalid_file_path_error'
require_relative 'image_downloader/errors/invalid_file_type_error'
require_relative 'image_downloader/errors/invalid_protocol_error'
require_relative 'image_downloader/errors/invalid_response_code_error'
require_relative 'image_downloader/errors/invalid_url_error'

# ImageDownloader namespace
module ImageDownloader
end
