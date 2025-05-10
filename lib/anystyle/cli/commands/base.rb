module AnyStyle
  module CLI
    module Commands
      class Base
        attr_reader :options, :output_folder

        def initialize(options)
          @options = options
        end

        def run(args, params)
          raise NotImplementedYet
        end

        def verbose?
          !!options[:verbose]
        end

        def stdout?
          !!options[:stdout]
        end

        def overwrite?
          !!options[:overwrite]
        end

        def each_format(&block)
          options[:format].each(&block)
        end

        def find(input, opts = {})
          AnyStyle.find(input,
            format: :wapiti,
            layout: opts[:layout],
            crop: opts[:crop].nil? ? nil : opts[:crop].map(&:to_i))
        end

        def parse_file(file)
          parse(Wapiti::Dataset.open(file, **AnyStyle::Parser.defaults))
        end

        def parse(input)
          AnyStyle.parse(input, format: :wapiti)
        end

        def format(dataset, fmt)
          case fmt
          when 'bib'
            AnyStyle.parser.format_bibtex(dataset).to_s
          when 'csl'
            JSON.pretty_generate AnyStyle.parser.format_csl(dataset)
          when 'ris'
            JSON.pretty_generate AnyStyle.parser.format_ris(dataset)
          when 'json'
            JSON.pretty_generate AnyStyle.parser.format_hash(dataset)
          when 'ref', 'txt'
            dataset.to_txt
          when 'xml'
            dataset.to_xml(indent: 2).to_s
          else
            raise ArgumentError, "format not supported: #{fmt}"
          end
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
          case path
          when nil, '-'
            options[:stdout] = true
          else
            @output_folder = Pathname.new(path).expand_path
          end
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
          STDERR.puts(*args) if verbose?
        end

        def report(error, file)
          STDERR.puts "Error processing `#{file}'"
          STDERR.puts "  #{error.message}"
          STDERR.puts "  #{error.backtrace[0]}"
          STDERR.puts "  #{error.backtrace[1]}"
          STDERR.puts "  ..."
        end

        def walk(input)
          path = Pathname(input).expand_path
          raise ArgumentError, "path does not exist: #{input}" unless path.exist?

          if path.directory?
            path.each_child do |file|
              begin
                yield file, path unless file.directory?
              rescue => e
                report e, file.relative_path_from(path)
              end
            end
          else
            begin
              yield path, path.dirname
            rescue => e
              report e, path.basename
            end
          end
        end

        def write(content, path, base_path)
          if stdout?
            STDOUT.puts(content)
          else
            path = transpose(path, base_path)
            if !overwrite? && path.exist?
              raise RuntimeError,
                "file exists, use --overwrite to force saving: #{path}"
            end
            File.write path, content
          end
        end
      end
    end
  end
end
