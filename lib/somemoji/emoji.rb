module Somemoji
  class Emoji
    # @return [Array<String>]
    attr_reader :aliases

    # @return [Array<String>]
    attr_reader :ascii_arts

    # @return [String, nil]
    attr_reader :category

    # @return [Array<Array<String>>]
    attr_reader :code_points_alternates

    # @return [Array<String>, nil]
    attr_reader :code_points

    # @return [String, nil]
    attr_reader :code

    # @return [Array<String>, nil]
    attr_reader :keywords

    # @return [String, nil]
    attr_reader :name

    def initialize(
      aliases: nil,
      ascii_arts: nil,
      category: nil,
      code_points_alternates: nil,
      code_points: nil,
      code:,
      keywords: nil,
      name: nil
    )
      @aliases = aliases || []
      @ascii_arts = ascii_arts || []
      @category = category
      @code_points_alternates = code_points_alternates || []
      @code_points = code_points
      @code = code
      @keywords = keywords || []
      @name = name
    end

    # @return [Array<Integer>]
    def code_points_in_decimal
      code_points.map do |code_point|
        code_point.to_i(16)
      end
    end

    # @return [String]
    def to_s
      code_points_in_decimal.pack("U*")
    end
  end
end
