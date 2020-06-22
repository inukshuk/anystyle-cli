module AnyStyle
  module CLI
    module Commands
      class ParseReference < Base
        def run(args, params)
          set_output_folder args[1]
          ref = args[0]
          dataset = parse(ref)
          say "Parsing citation: #{ref} ..."
          each_format do |fmt|
            res = format(dataset, fmt)
            STDOUT.puts(res)
          end
        end
      end
    end
  end
end
