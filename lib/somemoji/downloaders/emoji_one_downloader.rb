module Somemoji
  module Downloaders
    class EmojiOneDownloader < BaseDownloader
      HOST = "raw.githubusercontent.com"

      private

      def directory_name
        case
        when @format == "svg"
          "svg"
        when [128, 512].include?(@size)
          "png_#{@size}x#{@size}"
        else
          "png"
        end
      end

      # @note Implementation for Somemoji::Downloaders::BaseDownloader
      def find_remote_emoji_path(emoji)
        "/Ranks/emojione/v2.2.6/assets/#{directory_name}/#{emoji.code_points.join('-').downcase}.#{extension}"
      end

      # @return [String]
      def host
        HOST
      end
    end
  end
end
