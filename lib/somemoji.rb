require "json"
require "somemoji/emoji_collection"
require "somemoji/emoji"
require "somemoji/emoji_extractors/base_emoji_extractor"
require "somemoji/emoji_extractors/apple_emoji_extractor"
require "somemoji/emoji_extractors/downloadable_emoji_extractor"
require "somemoji/emoji_extractors/emoji_one_emoji_extractor"
require "somemoji/emoji_extractors/twemoji_emoji_extractor"
require "somemoji/version"

module Somemoji
  class << self
    # @return [Somemoji::EmojiCollection]
    def apple_emoji_collection
      @apple_emoji_collection ||= ::Somemoji::EmojiCollection.new(apple_emojis)
    end

    # @return [String]
    def apple_supported_characters_path
      ::File.expand_path("../../data/apple_supported_characters.json", __FILE__)
    end

    # @return [Somemoji::EmojiCollection]
    def emoji_collection
      @emoji_collection ||= ::Somemoji::EmojiCollection.new(emojis)
    end
    alias_method :emoji_one_emoji_collection, :emoji_collection

    # @return [String]
    def emoji_definitions_directory_path
      ::File.expand_path("../../data/emoji_definitions", __FILE__)
    end

    # @return [Somemoji::EmojiCollection]
    def twemoji_emoji_collection
      @twemoji_emoji_collection ||= ::Somemoji::EmojiCollection.new(twemoji_emojis)
    end

    # @return [String]
    def twemoji_supported_characters_path
      ::File.expand_path("../../data/twemoji_supported_characters.json", __FILE__)
    end

    private

    # @return [Array<Twemoji::Emoji>]
    def apple_emojis
      apple_supported_characters.map do |character|
        emoji_collection.find_by_character(character)
      end.compact
    end

    # @return [Array<String>]
    def apple_supported_characters
      ::JSON.parse(::File.read(apple_supported_characters_path))
    end

    # @return [Array<String>]
    def emoji_definition_paths
      ::Dir.glob("#{emoji_definitions_directory_path}/*.json").sort
    end

    # @return [Array<Hash>]
    def emoji_definitions
      emoji_definition_paths.map do |emoji_definition_path|
        ::JSON.parse(::File.read(emoji_definition_path))
      end
    end

    # @return [Array<Somemoji::Emoji>]
    def emojis
      emoji_definitions.map do |hash|
        ::Somemoji::Emoji.new(
          aliases: hash["aliases"],
          ascii_arts: hash["ascii_arts"],
          category: hash["category"],
          code_points_alternates: hash["code_points_alternates"],
          code_points: hash["code_points"],
          code: hash["code"],
          keywords: hash["keywords"],
          name: hash["name"],
        )
      end
    end

    # @return [Array<Twemoji::Emoji>]
    def twemoji_emojis
      twemoji_supported_characters.map do |character|
        emoji_collection.find_by_character(character)
      end.compact
    end

    # @return [Array<String>]
    def twemoji_supported_characters
      ::JSON.parse(::File.read(twemoji_supported_characters_path))
    end
  end
end
