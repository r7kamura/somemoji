require "emoji/extractor"
require "fileutils"
require "tmpdir"

module Somemoji
  module EmojiExtractors
    class AppleEmojiExtractor < BaseEmojiExtractor
      IMAGE_SIZE = 64

      # @note Implementation for Somemoji::EmojiExtractors::BaseEmojiExtractor
      def extract
        extract_into_unicode_directory
        make_directory
        move_images_into_specified_directory
        remove_unicode_directory
      end

      private

      def extract_into_unicode_directory
        ::Emoji::Extractor.new(IMAGE_SIZE, temporary_directory_path).extract!
      end

      def move_images_into_specified_directory
        ::Dir.glob("#{unicode_directory_path}/*.png").each do |image_path|
          character = ::File.basename(image_path, ".png").split("-").map do |code_point|
            code_point.to_i(16)
          end.pack("U*")
          if emoji = ::Somemoji.emoji_collection.find_by_character(character)
            ::FileUtils.mv(image_path, "#{@directory_path}/#{emoji.code}.png")
          end
        end
      end

      def remove_unicode_directory
        ::FileUtils.rm_r(unicode_directory_path)
      end

      def temporary_directory_path
        @temporary_directory_path ||= ::Dir.tmpdir
      end

      def unicode_directory_path
        "#{temporary_directory_path}/unicode"
      end
    end
  end
end
