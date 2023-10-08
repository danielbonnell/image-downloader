# frozen_string_literal: true

require 'open-uri'
require 'uri'
require 'net/http'
require 'fileutils'

module ImageDownloader
  # This class encapsulates all the logic for parsing and validating URLs the input txt file,
  # downloading each image, and logging any errors.
  class Client
    def initialize(file_path:)
      @file_path = file_path
      @errors = {}

      valid_file_path?
    end

    # Parse and validate URLs from txt file, download all images, and log all errors.
    def call
      create_directory!

      valid_file_urls.each do |url|
        download_image!(url:)
      end

      print_errors
    end

    attr_reader :file_path, :file, :directory_name, :errors

    # Iterates through list of URLs from a file checking the validity of each URL and returns
    # only the valid entries.
    def valid_file_urls
      @valid_file_urls ||= File
                           .read(file_path)
                           .split(/\s/)
                           .filter { |url| valid_url?(url:) }
                           .tap do |urls|
        raise Errors::BlankFileError if urls.empty?
      end
    end

    private

    def valid_file_path?
      return false if File.exist?(file_path) && file_path.match?(/^.*\.(txt)$/i)

      raise Errors::InvalidFilePathError
    end

    # Set the value of `@current_url`
    def set_current_url(url:)
      @current_url = url
    end

    # Validates a url is valid, returns an HTTP 200 status code, and links to a valid image file.
    # Returns a valid URL or logs the appropriate error.
    def valid_url?(url:)
      set_current_url(url:)

      return log_error(error: Errors::InvalidUrl).new(url:) unless url =~ URI::DEFAULT_PARSER.make_regexp

      uri     = URI.parse(url)
      request = Net::HTTP.new(uri.host, uri.port)

      return log_error(error: Errors::InvalidProtocolError.new(url:))     unless validate_uri_scheme(uri:, request:)
      return log_error(error: Errors::InvalidResponseCodeError.new(url:)) unless valid_response?(uri:, request:)
      return log_error(error: Errors::InvalidFileTypeError.new(url:))     unless valid_image?(uri:, request:)

      url
    end

    # Validates that the Content-Type of the passed Net::HTTP response object is an image
    def valid_image?(uri:, request:)
      request.head(uri.request_uri)['Content-Type'].start_with? 'image'
    rescue StandardError => e
      log_error(error: e)
    end

    # Validates the passed Net::HTTP request returns an HTTP 2xx status code
    def valid_response?(uri:, request:)
      return false unless (response = request.request_head(uri.path)).is_a? Net::HTTPOK

      response
    rescue StandardError => e
      log_error(error: e)
    end

    # Validates the scheme of the passed Net::HTTP request object
    def validate_uri_scheme(uri:, request:)
      case uri.scheme
      when 'https'
        request.use_ssl = true
      when 'http'
        true
      else
        false
      end
    end

    # Creates a directory to store the downloaded images in.
    def create_directory!
      @directory_name = [Dir.getwd, "downloaded-images-#{Time.now.to_i}"].join('/')

      FileUtils.mkdir_p(directory_name)
    end

    # Writes image from the url to disk
    def download_image!(url:)
      image     = URI.parse(url).open
      file_name = url.split('/')[-1]
      file_path = "#{directory_name}/#{file_name}"

      File.binwrite(file_path, image.read)
    rescue StandardError => e
      log_error(error: e)
    end

    # Store error to `@errors` array.
    def log_error(error:)
      @errors[@current_url] ||= []
      @errors[@current_url] << error
    end

    # Print errors to console or modify in the future to log errors to a log file or external
    # service.
    def print_errors
      puts 'ImageDownloader::Client#call results:'
      puts "Failed downloads: #{errors.count}"

      errors.values.flatten.each do |error|
        next error.print if error.respond_to?(:print)

        puts error
      end
    end
  end
end
