module AnyStyle
  module CLI
    module Commands
      class Parse < Base
        def run(*args, **params)
          super params
          walk args[0] do |file, base|
            say "Parsing #{file.relative_path_from(base)} ..."
            puts parse(file.to_s.untaint)
          end
        end

        def format
          params[:format]
        end

        def parse(file)
          case format
          when 'bib'
            AnyStyle.parse(file, format: :bibtex).to_s
          when 'csl'
            JSON.pretty_generate AnyStyle.parse(file, format: :csl)
          when 'json'
            JSON.pretty_generate AnyStyle.parse(file, format: :hash)
          when 'xml'
            AnyStyle.parse(file, format: :wapiti).to_xml(indent: 2).to_s
          else
            raise ArgumentError, "format not supported: #{format}"
          end
        end
      end
    end
  end
end
