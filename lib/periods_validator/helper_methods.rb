module ActiveModel
  module Validations
    module HelperMethods
      def validates_periods(*attr_names)
        validates_with PeriodsValidator, _merge_attributes(attr_names)
      end
    end
  end
end
