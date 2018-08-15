module AnyStyle
  module CLI
    module Commands
      class Check < Base
        def run(args, params)
          walk args[0] do |path|
            print 'Checking %.25s' % "#{path.basename}....................."
            start = Time.now
            stats = check path
            report stats, Time.now - start
          end
        end

        def check(path)
          case path.extname
          when '.ttx'
            AnyStyle.finder.check path.to_s.untaint
          when '.xml'
            AnyStyle.parser.check path.to_s.untaint
          else
            raise ArgumentError, "cannot check untagged input: #{path}"
          end
        end

        def report(stats, time)
          if stats[:token][:errors] == 0
            puts '   ✓                               %2ds' % time
          else
            puts '%4d seq %6.2f%% %6d tok %5.2f%% %2ds' % [
              stats[:sequence][:errors],
              stats[:sequence][:rate],
              stats[:token][:errors],
              stats[:token][:rate],
              time
            ]
          end
        end
      end
    end
  end
end
