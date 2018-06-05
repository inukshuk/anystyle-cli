module AnyStyle
  module CLI
    module Commands
      class Find < Base
        def run(args, params)
          super params
          say 'Find'
        end
      end
    end
  end
end
