require "net/https"

module Somemoji
  module EmojiExtractors
    class DownloadableEmojiExtractor < BaseEmojiExtractor
      # @note Implementation for Somemoji::EmojiExtractors::BaseEmojiExtractor
      def extract
        make_directory
        emojis.each do |emoji|
          download(emoji)
        end
      end

      private

      # @param emoji [Somemoji::Emoji]
      # @return [Boolean]
      def download(emoji)
        http = ::Net::HTTP.new(host, 443)
        http.use_ssl = true
        response = http.get(find_remote_emoji_path(emoji))
        if response.code == "200"
          ::File.write("#{@directory_path}/#{emoji.code}.#{extension}", response.body)
          true
        else
          false
        end
      end

      # @return [Enumerable]
      def emojis
        raise ::NotImplementedError
      end

      # @return [String]
      def extension
        if @format == "svg"
          "svg"
        else
          "png"
        end
      end

      # @param emoji [Somemoji::Emoji]
      # @return [String]
      def find_remote_emoji_path(emoji)
        raise ::NotImplementedError
      end

      # @return [String]
      def host
        raise ::NotImplementedError
      end
    end
  end
end