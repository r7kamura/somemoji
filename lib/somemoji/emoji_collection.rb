module Somemoji
  class EmojiCollection
    include ::Enumerable

    # @return [Array<Somemoji::Emoji>]
    attr_reader :emojis

    # @param emojis [Array<Somemoji::Emoji>]
    def initialize(emojis = [])
      @emojis = emojis
    end

    # @param emoji_collection [Somemoji::EmojiCollection]
    # @return [Somemoji::EmojiCollection]
    def +(emoji_collection)
      self.class.new(emojis + emoji_collection.emojis)
    end

    # @note Implementation for Enumerable
    def each(&block)
      emojis.each(&block)
    end

    # @param character [String] e.g. `"\u2934"`
    def find_by_character(character)
      index_by_character[character]
    end

    # @param code [String] e.g. `"arrow_heading_up"`
    def find_by_code(code)
      index_by_code[code]
    end

    private

    # @return [Hash{String => Somemoji::Emoji}]
    def index_by_character
      @index_by_character ||= emojis.each_with_object({}) do |emoji, hash|
        hash[emoji.character] = emoji
        emoji.alternate_characters.each do |alternate_character|
          hash[alternate_character] = emoji
        end
      end
    end

    # @return [Hash{String => Somemoji::Emoji}]
    def index_by_code
      @index_by_code ||= emojis.each_with_object({}) do |emoji, hash|
        hash[emoji.code] = emoji
        emoji.aliases.each do |alias_code|
          hash[alias_code] = emoji
        end
      end
    end
  end
end
