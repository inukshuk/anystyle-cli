module AnyStyle
  module CLI
    module Commands
      class Base
        attr_reader :options, :params

        def initialize(options)
          @options = options
        end

        def run(params)
          @params = params
        end

        def verbose?
          !!options[:verbose]
        end

        private

        def walk(input)
          path = Pathname(input).expand_path
          raise ArgumentError, "path does not exist: #{input}" unless path.exist?

          if path.directory?
            path.each_child do |file|
              yield file, path unless file.directory?
            end
          else
            yield path, path.dirname
          end
        end

        def say(*args)
          STDERR.puts(*args) if verbose?
        end

        def puts(*args)
          STDOUT.puts(*args)
        end
      end
    end
  end
end
