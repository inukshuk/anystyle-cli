module AnyStyle
  module CLI
    module Commands
      class Parse < Base
        def run(*args, **params)
          super params
          walk args[0] do |file|
            say "Parse #{file}"
          end
        end
      end
    end
  end
end
