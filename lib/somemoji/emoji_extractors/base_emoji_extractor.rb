require "fileutils"

module Somemoji
  module EmojiExtractors
    class BaseEmojiExtractor
      # @param destination [String]
      # @param format [String]
      # @param silence [Boolean]
      # @param size [Integer, nil]
      def initialize(format: nil, destination:, silence: nil, size: nil)
        @destination = destination
        @format = format || "png"
        @silence = silence || false
        @size = size
      end

      def extract
        raise ::NotImplementedError
      end

      private

      def make_destination_directory
        ::FileUtils.mkdir_p(@destination)
      end

      def silence?
        !!@silence
      end
    end
  end
end
