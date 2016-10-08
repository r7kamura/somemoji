module Somemoji
  class CommandLineArguments
    # @param argv [Array<String>]
    def initialize(argv)
      @argv = argv
    end

    # @return [String]
    def destination
      slop_parse_result[:destination]
    end

    # @return [String]
    def error_message
      slop_options.to_s
    end

    # @return [String, nil]
    def format
      slop_parse_result[:format]
    end

    # @return [String]
    def provider_name
      slop_parse_result[:provider]
    end

    # @return [Integer, nil]
    def size
      slop_parse_result[:size]
    end

    # @return [Boolean]
    def valid?
       command_name == "extract" && !slop_parse_result.nil?
    end

    private

    # @return [String]
    def command_name
      @argv[0]
    end

    # @return [Slop::Options]
    def slop_options
      @slop_options ||= begin
        slop_options = ::Slop::Options.new
        slop_options.banner = "Usage: somemoji extract [options]"
        slop_options.string "-p", "--provider", "(required) apple, emoji_one, noto, or twemoji"
        slop_options.string "-d", "--destination", "(required) directory path to locate extracted image files"
        slop_options.string "-f", "--format", "png or svg (default: png)"
        slop_options.integer "-s", "--size", "Some providers have different size image files"
        slop_options.bool "-h", "--help", "Display this help message"
        slop_options
      end
    end

    # @return [Slop::Result]
    def slop_parse_result
      @slop_parse_result ||= ::Slop::Parser.new(slop_options).parse(@argv)
    rescue ::Slop::UnknownOption
    end
  end
end
