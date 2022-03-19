module Timeflip2
  module V2
    module API
      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end