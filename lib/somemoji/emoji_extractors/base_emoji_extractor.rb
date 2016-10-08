require "fileutils"

module Somemoji
  module EmojiExtractors
    class BaseEmojiExtractor
      # @param directory_path [String]
      # @param format [String]
      # @param silence [Boolean]
      # @param size [Integer, nil]
      def initialize(format: nil, directory_path:, silence: nil, size: nil)
        @directory_path = directory_path
        @format = format || "png"
        @silence = silence || false
        @size = size
      end

      def extract
        raise ::NotImplementedError
      end

      private

      def make_directory
        ::FileUtils.mkdir_p(@directory_path)
      end

      def silence?
        !!@silence
      end
    end
  end
end
