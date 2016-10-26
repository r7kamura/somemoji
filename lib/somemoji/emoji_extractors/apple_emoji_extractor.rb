require "emoji/extractor"
require "fileutils"
require "tmpdir"

module Somemoji
  module EmojiExtractors
    class AppleEmojiExtractor < BaseEmojiExtractor
      IMAGE_SIZE = 64

      # @note Implementation for Somemoji::EmojiExtractors::BaseEmojiExtractor
      def extract
        extract_images_into_temporary_directory
        extracted_image_paths.map do |image_path|
          if emoji = emoji_table[::File.basename(image_path, ".png").split("-")]
            ::FileUtils.mkdir_p("#{@destination}/unicode")
            ::FileUtils.move(
              image_path,
              "#{@destination}/#{emoji.base_path}.png",
            )
          end
        end
      end

      private

      def emoji_table
        @emoji_table ||= ::Somemoji.emoji_collection.each_with_object({}) do |emoji, object|
          object[emoji.abbreviated_code_points] = emoji
        end
      end

      def extract_images_into_temporary_directory
        ::Emoji::Extractor.new(IMAGE_SIZE, temporary_directory_path).extract!
      end

      def extracted_image_paths
        ::Dir.glob("#{temporary_directory_path}/unicode/*.png")
      end

      def temporary_directory_path
        @temporary_directory_path ||= ::Dir.tmpdir
      end
    end
  end
end
