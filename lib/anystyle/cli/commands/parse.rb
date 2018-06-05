module AnyStyle
  module CLI
    module Commands
      class Parse < Base
        def run(args, params)
          super params
          set_output_folder args[1]
          walk args[0] do |path, base_path|
            say "Parsing #{path.relative_path_from(base_path)} ..."
            dataset = parse(path.to_s.untaint)
            say "#{dataset.length} references found.\n"

            params[:format].each do |fmt|
              say "Formatting reference as #{fmt} ...\n"
              res = format(dataset, fmt)
              out = extsub(path, ".#{fmt}")
              say "Writing #{out.relative_path_from(base_path)} ...\n"
              write res, out, base_path
            end
          end
        end

        def parse(path)
          AnyStyle.parse(path, format: :wapiti)
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
