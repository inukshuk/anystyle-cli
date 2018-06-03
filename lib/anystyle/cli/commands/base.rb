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

        def walk(path)
          path = File.expand_path(path)
          raise ArgumentError, "path does not exist: #{path}" unless File.exists?(path)

          if File.directory?(path)
            Dir.children(path).each do |file|
              yield File.join(path, file), path
            end
          else
            yield path, File.basename(path)
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
