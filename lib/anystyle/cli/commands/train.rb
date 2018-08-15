module AnyStyle
  module CLI
    module Commands
      class Train < Base
        def run(args, params)
          check_no_overwrite! args[1]

          Wapiti.debug!
          model = train(args[0])

          if args[1].nil?
            model.save
          else
            model.save File.expand_path(args[1]).untaint
          end
        end

        def train(path)
          case
          when File.extname(path) == '.xml'
            AnyStyle.parser.train path.to_s.untaint
            AnyStyle.parser.model
          when File.directory?(path)
            AnyStyle.finder.train path.to_s.untaint
            AnyStyle.finder.model
          else
            raise ArgumentError, "cannot train input: #{path}"
          end
        end

        def check_no_overwrite!(path)
          if !overwrite? && (path.nil? || File.exist?(path))
            raise RuntimeError,
              "file exists, use --overwrite to force saving: #{path}"
          end
        end
      end
    end
  end
end

