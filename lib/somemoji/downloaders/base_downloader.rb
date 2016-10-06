require "net/https"

module Somemoji
  module Downloaders
    class BaseDownloader
      # @param directory_path [String]
      # @param format [String]
      # @param size [Integer, nil]
      def initialize(format: nil, directory_path:, size: nil)
        @directory_path = directory_path
        @format = format || "png"
        @size = size
      end

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

      private

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
