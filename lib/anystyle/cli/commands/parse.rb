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
            each_format do |fmt|
              say "Formatting references as #{fmt} ...\n"
              res = format(dataset, fmt)
              out = extsub(path, ".#{fmt}")
              say "Writing #{out.relative_path_from(base_path)} ...\n"
              write res, out, base_path
            end
          end
        end
      end
    end
  end
end
