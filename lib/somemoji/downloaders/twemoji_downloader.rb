module Somemoji
  module Downloaders
    class TwemojiDownloader < BaseDownloader
      HOST = "raw.githubusercontent.com"

      private

      def directory_name
        case
        when @format == "svg"
          "svg"
        when [16, 36].include?(@size)
          "#{@size}x#{@size}"
        else
          "72x72"
        end
      end

      # @note Implementation for Somemoji::Downloaders::BaseDownloader
      def find_remote_emoji_path(emoji)
        "/twitter/twemoji/v2.2.1/#{directory_name}/#{emoji.code_points.join('-').downcase}.#{extension}"
      end

      # @return [String]
      def host
        HOST
      end
    end
  end
end
