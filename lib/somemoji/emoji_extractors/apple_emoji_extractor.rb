require "emoji/extractor"
require "fileutils"
require "tmpdir"

module Somemoji
  module EmojiExtractors
    class AppleEmojiExtractor < BaseEmojiExtractor
      IMAGE_SIZE = 64

      # @note Implementation for Somemoji::EmojiExtractors::BaseEmojiExtractor
      def extract
        ::Emoji::Extractor.new(IMAGE_SIZE, @destination).extract!
      end
    end
  end
end
