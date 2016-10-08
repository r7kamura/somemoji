module Somemoji
  module Commands
    class ErrorCommand < BaseCommand
      def call
        abort(command_line_arguments.error_message)
      end
    end
  end
end
