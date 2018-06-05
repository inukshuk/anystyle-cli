module AnyStyle
  module CLI
    module Commands
      class Find < Base
        def run(args, params)
          super params
          set_output_folder args[1]
          walk args[0] do |path, base_path|
            say "Analyzing #{path.relative_path_from(base_path)} ..."
            doc = find(path.to_s.untaint)
            ref = doc[0].references

            if ref.length == 0
              say "no references found.\n"
            else
              say "#{ref.length} references found.\n"
              dst = nil
              each_format do |fmt|
                case fmt
                when 'ttx'
                  say "Formatting document as #{fmt} ...\n"
                  res = doc.to_txt tagged: true
                when 'txt'
                  say "Formatting document as #{fmt} ...\n"
                  res = doc.to_txt tagged: false
                when 'ref'
                  say "Formatting references as #{fmt} ...\n"
                  res = ref.join("\n")
                else
                  say "Formatting references as #{fmt} ...\n"
                  dst ||= parse(ref.join("\n"))
                  res = format(dst, fmt)
                end

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
end
