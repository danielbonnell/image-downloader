# frozen_string_literal: true

require 'image_downloader'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.after(:each) do
    Dir[File.expand_path(File.join(File.dirname(__FILE__), '..', 'downloaded-images-*'))].each do |path|
      FileUtils.rm_rf(path)
    end
  end
end
