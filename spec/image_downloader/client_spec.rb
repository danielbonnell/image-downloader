# frozen_string_literal: true

RSpec.describe ImageDownloader::Client do
  subject { ImageDownloader::Client.new(file_path:) }

  let(:dir_path) { Dir[File.expand_path File.join(File.dirname(__FILE__), '..', '..', 'downloaded-images-*')][0] }
  let(:file_path) { File.expand_path File.join(File.dirname(__FILE__), '..', 'fixtures', 'urls.txt') }

  context 'with an invalid file_path' do
    context 'when file_path contains an invalid file extension' do
      let(:file_path) { "#{File.dirname(__FILE__)}/../fixtures/urls.doc" }

      it 'raises an InvalidFilePathError' do
        expect { subject.call }.to raise_error ImageDownloader::Errors::InvalidFilePathError
      end
    end

    context 'when file_path contains an no file extension' do
      let(:file_path) { "#{File.dirname(__FILE__)}/../fixtures/urls" }

      it 'raises an InvalidFilePathError' do
        expect { subject.call }.to raise_error ImageDownloader::Errors::InvalidFilePathError
      end
    end

    context 'when file_path is not found' do
      let(:file_path) { "#{File.dirname(__FILE__)}/../fixtures/invalid_file.txt" }

      it 'raises an InvalidFilePathError' do
        expect { subject.call }.to raise_error ImageDownloader::Errors::InvalidFilePathError
      end
    end
  end

  context 'with a valid file_path' do
    context 'when file is blank' do
      let(:file_path) do
        File.expand_path File.join(File.dirname(__FILE__), '..', 'fixtures', 'blank.txt')
      end

      it 'raises BlankFileError' do
        expect { subject.call }.to raise_error ImageDownloader::Errors::BlankFileError
      end
    end

    context 'when file contains a mix of valid image URLs and valid non-image URLs' do
      before { subject.call }

      it 'downloads all images to correct directory' do
        expect(subject.errors.keys.count).to eq(1)
        expect(subject.valid_file_urls.count).to eq(3)
        expect(dir_path).not_to be_nil
        expect(Dir[File.join(dir_path, '**', '*')].count { |file| File.file?(file) }).to be_positive
      end

      it 'logs the expected errors' do
        expect(subject.errors.keys.count).to eq(1)
      end
    end

    context 'when file contains all invalid URLs' do
      let(:file_path) do
        File.expand_path File.join(File.dirname(__FILE__), '..', 'fixtures', 'invalid_urls.txt')
      end

      before { subject.call }

      it 'does not download any images' do
        expect(dir_path).not_to be_nil
        expect(Dir[File.join(dir_path, '**', '*')].count { |file| File.file?(file) }).to eq(0)
      end

      it 'logs the expected errors' do
        expect(subject.errors.keys.count).to eq(3)
      end
    end
  end
end
