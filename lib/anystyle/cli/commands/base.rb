module AnyStyle
  module CLI
    module Commands
      class Base
        attr_reader :options, :params, :output_folder

        def initialize(options)
          @options = options
        end

        def run(params)
          @params = params
        end

        def verbose?
          !!options[:verbose]
        end

        def stdout?
          !!params[:stdout]
        end

        def overwrite?
          !!params[:overwrite]
        end

        def extsub(path, new_extname)
          basename = path.basename(path.extname)
          path.dirname.join("#{basename}#{new_extname}")
        end

        def transpose(path, base_path)
          if output_folder.nil?
            path
          else
            output_folder.join(path.relative_path_from(base_path))
          end
        end

        def set_output_folder(path)
          @output_folder = Pathname.new(path).expand_path unless path.nil?
        ensure
          unless @output_folder.nil?
            if @output_folder.exist?
              raise ArgumentError,
                "not a directory: #{path}" unless @output_folder.directory?
            else
              @output_folder.mkdir
            end
          end
        end

        def say(*args)
          STDERR.print(*args) if verbose?
        end

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

        def write(content, path, base_path)
          if stdout?
            STDOUT.puts(content)
          else
            path = transpose(path, base_path)
            if !overwrite? && File.exists?(path)
              raise RuntimeError,
                "file exists, use --overwrite to force saving: #{path}"
            end
            File.open(path, 'w+') { |f| f << content }
          end
        end
      end
    end
  end
end
