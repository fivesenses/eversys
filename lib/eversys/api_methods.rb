module Eversys
  module ApiMethods
    def get(*args)
      case args.length
      when 0
        get_collection
      when 1
        get_by_id(args[0]).first
      end
    end
  end
end
