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

    private

    # @return [Array<Hash>]
    def emoji_definitions
      emoji_definition_paths.map do |emoji_definition_path|
        ::JSON.parse(::File.read(emoji_definition_path))
      end
    end

    # @return [String]
    def emoji_definitions_directory_path
      ::File.expand_path("../../data/emoji_definitions", __FILE__)
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
