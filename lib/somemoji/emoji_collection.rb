module Somemoji
  class EmojiCollection
    include ::Enumerable

    # @param emojis [Array<Somemoji::Emoji>]
    def initialize(emojis = [])
      @emojis = emojis
    end

    # Compounds two emoji collections into a new one
    # @param emoji_collection [Somemoji::EmojiCollection]
    # @return [Somemoji::EmojiCollection] a new emoji collection
    # @example
    #   custom_emoji_collection = Somemoji.emoji_collection + Somemoji::EmojiCollection.new(
    #     [
    #       Somemoji::Emoji.new(code: "foo"),
    #       Somemoji::Emoji.new(code: "bar"),
    #     ]
    #   )
    #   custom_emoji_collection.find_by_code("foo").class #=> Somemoji::Emoji
    #   custom_emoji_collection.find_by_code("bar").class #=> Somemoji::Emoji
    #   custom_emoji_collection.find_by_code("100").class #=> Somemoji::Emoji
    def +(emoji_collection)
      self.class.new(to_a + emoji_collection.to_a)
    end

    # @return [Regexp] a regexp to match with emoji characters
    def character_pattern
      @character_pattern ||= ::Regexp.union(characters)
    end

    # @return [Array<String>] all emoij characters included in this collection
    def characters
      index_by_character.keys
    end

    # @return [Regexp] a regexp to match with emoji codes
    def code_pattern
      @code_pattern ||= /:(#{::Regexp.union(codes)}):/
    end

    # @return [Array<String>] all emoji codes included in this collection
    def codes
      index_by_code.keys
    end

    # @note Implementation for Enumerable
    def each(&block)
      @emojis.each(&block)
    end

    # @param category [Object]
    # @return [Somemoji::EmojiCollection] a emoji collection filtered by a given category pattern
    # @example
    #   Somemoji.emoji_collection.filter_by_category("activity").count #=> 145
    #   Somemoji.emoji_collection.filter_by_category("people").count #=> 570
    def filter_by_category(category)
      ::Somemoji::EmojiCollection.new(
        select do |emoji|
          category === emoji.category
        end
      )
    end

    # @param keyword [Object]
    # @return [Somemoji::EmojiCollection] a emoji collection filtered by a given keyword pattern
    # @example
    #   Somemoji.emoji_collection.filter_by_keyword("numbers").count #=> 13
    #   Somemoji.emoji_collection.filter_by_keyword("vehicle").count #=> 31
    def filter_by_keyword(keyword)
      ::Somemoji::EmojiCollection.new(
        select do |emoji|
          emoji.keywords.any? do |emoji_keyword|
            keyword === emoji_keyword
          end
        end
      )
    end

    # Finds an emoji from an emoji character (a.k.a. unicode grapheme cluster)
    # @param character [String] an emoji character (e.g. "\u2934")
    # @return [Somemoji::Emoji, nil]
    # @example
    #   Somemoji.emoji_collection.find_by_character("👍").class #=> Somemoji::Emoji
    #   Somemoji.emoji_collection.find_by_character("👎").class #=> Somemoji::Emoji
    def find_by_character(character)
      index_by_character[character]
    end

    # Finds an emoji from an emoji code
    # @param code [String] an emoji code (e.g. "arrow_heading_up")
    # @return [Somemoji::Emoji, nil]
    # @example
    #   Somemoji.emoji_collection.find_by_code("thumbsup").class #=> Somemoji::Emoji
    #   Somemoji.emoji_collection.find_by_code("+1").class #=> Somemoji::Emoji
    #   Somemoji.emoji_collection.find_by_code("undefined_code") #=> nil
    def find_by_code(code)
      index_by_code[code]
    end

    # Replaces emoji characters in a given string with a given block result
    # @param string [String] a string that to be replaced
    # @return [String] a replaced result
    # @example
    #   Somemoji.emoji_collection.replace_character("I ❤ Emoji") do |emoji|
    #     %(<img alt="#{emoji.character}" class="emoji" src="/assets/emoji/#{emoji.base_path}.png">)
    #   end
    #   #=> 'I <img alt="❤" class="emoji" src="/assets/emoji/unicode/2764.png"> Emoji'
    def replace_character(string, &block)
      string.gsub(character_pattern) do |character|
        block.call(find_by_character(character), character)
      end
    end

    # Replaces emoji codes in a given string with a given block result
    # @param string [String] a string that to be replaced
    # @return [String] a replaced result
    # @example
    #   Somemoji.emoji_collection.replace_code("I :heart: Emoji") do |emoji|
    #     %(<img alt="#{emoji.character}" class="emoji" src="/assets/emoji/#{emoji.base_path}.png">)
    #   end
    #   #=> 'I <img alt="❤" class="emoji" src="/assets/emoji/unicode/2764.png"> Emoji'
    def replace_code(string, &block)
      string.gsub(code_pattern) do |matched_string|
        block.call(find_by_code(::Regexp.last_match(1)), matched_string)
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
