module Somemoji
  module EmojiExtractors
    class NotoEmojiExtractor < DownloadableEmojiExtractor
      HOST = "raw.githubusercontent.com"

      private

      # @return [String]
      def directory_name
        if @format == "svg"
          "svg"
        else
          "png/128"
        end
      end

      # @note Implementation for Somemoji::EmojiExtractors::DownloadableEmojiExtractor
      def emojis
        ::Somemoji.noto_emoji_collection
      end

      # @note Implementation for Somemoji::EmojiExtractors::DownloadableEmojiExtractor
      def find_remote_emoji_path(emoji)
        "/googlei18n/noto-emoji/fcc3cfed6f7bad76ed7bb2012b3ac5232ced7a96/#{directory_name}/emoji_u#{emoji.code_points.join('_').downcase}.#{extension}"
      end

      # @note Implementation for Somemoji::EmojiExtractors::DownloadableEmojiExtractor
      # @return [String]
      def host
        HOST
      end
    end
  end
end
