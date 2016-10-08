module Somemoji
  module Commands
    class ExtractCommand < BaseCommand
      def call
        if emoji_extractor_class && command_line_arguments.destination
          emoji_extractor_class.new(
            destination: command_line_arguments.destination,
            format: command_line_arguments.format,
            size: command_line_arguments.size,
          ).extract
        else
          abort(command_line_arguments.error_message)
        end
      end

      private

      # @return [Class]
      def emoji_extractor_class
        case command_line_arguments.provider_name
        when "apple"
          ::Somemoji::EmojiExtractors::AppleEmojiExtractor
        when "emoji_one"
          ::Somemoji::EmojiExtractors::EmojiOneEmojiExtractor
        when "noto"
          ::Somemoji::EmojiExtractors::NotoEmojiExtractor
        when "twemoji"
          ::Somemoji::EmojiExtractors::TwemojiEmojiExtractor
        end
      end
    end
  end
end
