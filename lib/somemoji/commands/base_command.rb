module Somemoji
  module Commands
    class BaseCommand
      # @param command_line_arguments [Somemoji::CommandLineArguments]
      def initialize(command_line_arguments)
        @command_line_arguments = command_line_arguments
      end

      def call
        raise ::NotImplementedError
      end

      private

      # @return [Somemoji::CommandLineArguments]
      def command_line_arguments
        @command_line_arguments
      end
    end
  end
end
