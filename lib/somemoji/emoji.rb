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

    # @return [Array<String>, nil]
    attr_reader :keywords

    # @return [String, nil]
    attr_reader :name

    # @param aliases [Array<String>, nil]
    # @param ascii_arts [Array<String>, nil]
    # @param category [String, nil]
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
      keywords: nil,
      name: nil
    )
      @aliases = aliases || []
      @ascii_arts = ascii_arts || []
      @category = category
      @code = code
      @code_points = code_points || []
      @keywords = keywords || []
      @name = name
    end

    # @return [Array<String>]
    def abbreviated_code_points
      code_points.reject do |code_point|
        %w(200D FE0F).include?(code_point)
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

    # @return [String, nil] a String representation from its code points
    def character
      unless code_points.empty?
        code_points.map do |code_point|
          code_point.to_i(16)
        end.pack("U*")
      end
    end

    # @return [Hash{Symbol => Object}]
    def to_hash
      {
        aliases: aliases,
        ascii_arts: ascii_arts,
        category: category,
        code: code,
        code_points: code_points,
        keywords: keywords,
        name: name,
      }
    end
  end
end
