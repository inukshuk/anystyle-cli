module AnyStyle
  module CLI
    module Commands
      class Find < Base
        def run(args, params)
          set_output_folder args[1]
          walk args[0] do |path, base_path|
            say "Analyzing #{path.relative_path_from(base_path)} ..."
            doc = find(path.to_s.untaint, layout: params[:layout])
            ref = doc[0].references(normalize_blocks: !params[:solo])

            if ref.length == 0
              say "no references found."
            else
              say "#{ref.length} references found."
              dst = nil
              each_format do |fmt|
                case fmt
                when 'ttx'
                  res = doc.to_s tagged: true
                when 'txt'
                  res = doc.to_s tagged: false
                when 'ref'
                  res = ref.join("\n")
                else
                  dst ||= parse(ref.join("\n"))
                  res = format(dst, fmt)
                end

                out = extsub(path, ".#{fmt}")
                say "Writing #{out.relative_path_from(base_path)} ..."
                write res, out, base_path
              end
            end
          end
        end
      end
    end
  end
end
