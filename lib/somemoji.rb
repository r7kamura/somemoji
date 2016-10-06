require "json"
require "somemoji/downloaders/base_downloader"
require "somemoji/downloaders/emoji_one_downloader"
require "somemoji/downloaders/twemoji_downloader"
require "somemoji/emoji_collection"
require "somemoji/emoji"
require "somemoji/version"

module Somemoji
  class << self
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

    # @return [String]
    def twemoji_supported_characters_path
      ::File.expand_path("../../data/twemoji_supported_characters.json", __FILE__)
    end

    private

    # @return [Array<Hash>]
    def emoji_definitions
      emoji_definition_paths.map do |emoji_definition_path|
        ::JSON.parse(::File.read(emoji_definition_path))
      end
    end

    # @return [Array<String>]
    def emoji_definition_paths
      ::Dir.glob("#{emoji_definitions_directory_path}/*.json").sort
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
  end
end
