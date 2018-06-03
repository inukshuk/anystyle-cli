module AnyStyle
  module CLI
    class Command
      attr_accessor :verbose

      def initialize(verbose: false, **opts)
        @verbose = verbose
      end

      def execute
      end

      def verbose?
        !!@verbose
      end

      private

      def say(*args)
        STDERR.puts(*args) if verbose?
      end
    end
  end
end
