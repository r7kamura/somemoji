module Somemoji
  class CommandBuilder
    # @param argv [Array<String>]
    def initialize(argv)
      @argv = argv
    end

    # @return [Somemoji::Commands::BaseCommand]
    def build
      if command_line_arguments.valid?
        ::Somemoji::Commands::ExtractCommand.new(command_line_arguments)
      else
        ::Somemoji::Commands::ErrorCommand.new(command_line_arguments)
      end
    end

    private

    # @return [Somemoji::CommandLineArguments]
    def command_line_arguments
      @command_line_arguments ||= ::Somemoji::CommandLineArguments.new(@argv)
    end
  end
end
