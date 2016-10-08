module Somemoji
  class Emoji
    # @return [Array<String>]
    attr_reader :aliases

    # @return [Array<String>]
    attr_reader :ascii_arts

    # @return [String, nil]
    attr_reader :category

    # @return [String, nil]
    attr_reader :code

    # @return [Array<String>, nil]
    attr_reader :code_points

    # @return [Array<Array<String>>]
    attr_reader :code_points_alternates

    # @return [Array<String>, nil]
    attr_reader :keywords

    # @return [String, nil]
    attr_reader :name

    # @param aliases [Array<String>, nil]
    # @param ascii_arts [Array<String>, nil]
    # @param category [String, nil]
    # @param code_points_alternates [Array<Array<String>>, nil]
    # @param code_points [Array<String>, nil]
    # @param code [String] a unique emoji code (required)
    # @param keywords [Array<String>, nil]
    # @param name [String, nil]
    # @example
    #   emoji = Somemoji::Emoji.new(
    #     aliases: [],
    #     ascii_arts: [],
    #     category: "symbols",
    #     code: "100",
    #     code_points: [
    #       "1F4AF"
    #     ],
    #     code_points_alternates: [],
    #     keywords: [
    #       "100",
    #       "a",
    #       "exam",
    #       "numbers",
    #       "parties",
    #       "percent",
    #       "perfect",
    #       "plus",
    #       "quiz",
    #       "school",
    #       "score",
    #       "symbol",
    #       "test",
    #       "win",
    #       "wow"
    #     ],
    #     name: "hundred points symbol"
    #   )
    #   emoji.character #=> "💯"
    def initialize(
      aliases: nil,
      ascii_arts: nil,
      category: nil,
      code:,
      code_points: nil,
      code_points_alternates: nil,
      keywords: nil,
      name: nil
    )
      @aliases = aliases || []
      @ascii_arts = ascii_arts || []
      @category = category
      @code = code
      @code_points = code_points
      @code_points_alternates = code_points_alternates || []
      @keywords = keywords || []
      @name = name
    end

    # @return [Array<String>]
    def alternate_characters
      code_points_alternates.map do |code_points_alternate|
        code_points_alternate.map do |code_point|
          code_point.to_i(16)
        end.pack("U*")
      end
    end

    # @return [String]
    def base_path
      if code_points.empty?
        code
      else
        "unicode/#{code_points.join('-').downcase}"
      end
    end

    # @return [String] a String representation of an emoji (if code points are defined on this emoji)
    def character
      code_points.map do |code_point|
        code_point.to_i(16)
      end.pack("U*")
    end
  end
end
