module Somemoji
  module EmojiExtractors
    class TwemojiEmojiExtractor < DownloadableEmojiExtractor
      HOST = "raw.githubusercontent.com"

      private

      # @return [String]
      def directory_name
        if @format == "svg"
          "2/svg"
        else
          "2/72x72"
        end
      end

      # @note Implementation for Somemoji::EmojiExtractors::DownloadableEmojiExtractor
      def emojis
        ::Somemoji.emoji_one_emoji_collection
      end

      # @note Implementation for Somemoji::EmojiExtractors::DownloadableEmojiExtractor
      def find_remote_emoji_path(emoji)
        "/twitter/twemoji/v2.2.1/#{directory_name}/#{emoji.code_points.join('-').downcase}.#{extension}"
      end

      # @note Implementation for Somemoji::EmojiExtractors::DownloadableEmojiExtractor
      # @return [String]
      def host
        HOST
      end
    end
  end
end
