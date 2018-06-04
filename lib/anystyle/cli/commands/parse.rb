module AnyStyle
  module CLI
    module Commands
      class Parse < Base
        def run(*args, **params)
          super params
          walk args[0] do |file, base|
            say "Parsing #{file.relative_path_from(base)} ..."
            dataset = parse(file.to_s.untaint)
            params[:format].each do |fmt|
              say "Formatting #{dataset.length} reference as #{fmt} ..."
              puts format(dataset, fmt)
            end
          end
        end

        def parse(file)
          AnyStyle.parse(file, format: :wapiti)
        end

        def format(dataset, fmt)
          case fmt
          when 'bib'
            AnyStyle.parser.format_bibtex(dataset).to_s
          when 'csl'
            JSON.pretty_generate AnyStyle.parser.format_csl(dataset)
          when 'json'
            JSON.pretty_generate AnyStyle.parser.format_hash(dataset)
          when 'xml'
            dataset.to_xml(indent: 2).to_s
          else
            raise ArgumentError, "format not supported: #{fmt}"
          end
        end

      end
    end
  end
end
