require 'active_model/validator'

module PeriodsValidator
  class Validator < ActiveModel::EachValidator
    def initialize(options)
      @end_range = options.fetch(:end_range, nil)
      @end_range_attribute = options.fetch(:end_range_attribute, :end_range)
      @periods = options.fetch(:in, [])

      super
    end

    def validate_each(record, _attribute, value)
      end_range = @end_range || record.send(@end_range_attribute)
      options = {
        start_range: value,
        end_range: end_range,
        periods: @periods
      }

      validator = PeriodsValidator::Periods.new(options)

      return if validator.valid?

      record.errors.add(:base, validator.error)
    end
  end
end

unless defined? ActiveModel::Validations::PeriodsValidator
  ActiveModel::Validations::PeriodsValidator = PeriodsValidator::Validator
end
