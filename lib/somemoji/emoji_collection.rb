module Somemoji
  class EmojiCollection
    include ::Enumerable

    # @param emojis [Array<Somemoji::Emoji>]
    def initialize(emojis = [])
      @emojis = emojis
    end

    # @param emoji_collection [Somemoji::EmojiCollection]
    # @return [Somemoji::EmojiCollection]
    def +(emoji_collection)
      self.class.new(to_a + emoji_collection.to_a)
    end

    # @return [Regexp]
    def character_pattern
      @character_pattern ||= ::Regexp.union(characters)
    end

    # @return [Array<String>]
    def characters
      index_by_character.keys
    end

    # @return [Regexp]
    def code_pattern
      @code_pattern ||= /:(#{::Regexp.union(codes)}):/
    end

    # @return [Array<String>]
    def codes
      index_by_code.keys
    end

    # @note Implementation for Enumerable
    def each(&block)
      @emojis.each(&block)
    end

    # @param character [String] e.g. `"\u2934"`
    def find_by_character(character)
      index_by_character[character]
    end

    # @param code [String] e.g. `"arrow_heading_up"`
    def find_by_code(code)
      index_by_code[code]
    end

    # @param string [String]
    # @return [String]
    def replace_character(string, &block)
      string.gsub(character_pattern) do |character|
        block.call(find_by_character(character))
      end
    end

    # @param string [String]
    # @return [String]
    def replace_code(string, &block)
      string.gsub(code_pattern) do
        block.call(find_by_code(::Regexp.last_match(1)))
      end
    end

    private

    # @return [Hash{String => Somemoji::Emoji}]
    def index_by_character
      @index_by_character ||= each_with_object({}) do |emoji, hash|
        hash[emoji.character] = emoji
        emoji.alternate_characters.each do |alternate_character|
          hash[alternate_character] = emoji
        end
      end
    end

    # @return [Hash{String => Somemoji::Emoji}]
    def index_by_code
      @index_by_code ||= each_with_object({}) do |emoji, hash|
        hash[emoji.code] = emoji
        emoji.aliases.each do |alias_code|
          hash[alias_code] = emoji
        end
      end
    end
  end
end
