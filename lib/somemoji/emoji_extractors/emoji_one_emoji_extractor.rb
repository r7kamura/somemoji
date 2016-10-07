module Somemoji
  module EmojiExtractors
    class EmojiOneEmojiExtractor < DownloadableEmojiExtractor
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

      # @note Implementation for Somemoji::EmojiExtractors::DownloadableEmojiExtractor
      def emojis
        ::Somemoji.emoji_one_emoji_collection.each
      end

      # @note Implementation for Somemoji::EmojiExtractors::DownloadableEmojiExtractor
      def find_remote_emoji_path(emoji)
        "/Ranks/emojione/v2.2.6/assets/#{directory_name}/#{emoji.code_points.join('-').downcase}.#{extension}"
      end

      # @note Implementation for Somemoji::EmojiExtractors::DownloadableEmojiExtractor
      # @return [String]
      def host
        HOST
      end
    end
  end
end
