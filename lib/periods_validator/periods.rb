module PeriodsValidator
  class Periods
    attr_reader :error

    PERIODS = %i[monthly quarterly semesterly yearly].freeze
    MONTHS_QUARTERLY = [3, 6, 9, 12].freeze
    MONTHS_SEMESTERLY = [6, 12].freeze
    YEARLY = 11
    QUARTERLY = 2
    SEMESTERLY = 5

    def initialize(args={})
      @start_range = args.fetch(:start_range)
      @end_range = args.fetch(:end_range)
      @periods = args.fetch(:periods, [])
      @error = nil
      @months = 0
    end

    def valid?
      if @periods.empty? || !(@periods - PERIODS).empty?
        @error = :invalid_define_period
        return false
      end

      if @start_range.nil? || @end_range.nil?
        @error = :invalid_period
        return false
      end

      @months = (@end_range.year * 12 + @end_range.month) - (@start_range.year * 12 +
                                                             @start_range.month)

      @periods.each do |period|
        return true if send("period_#{period}")
      end

      @error = :invalid_period
      false
    end

    alias validate valid?

    protected

    def limits_date
      @start_range == @start_range.beginning_of_month && @end_range == @end_range.at_end_of_month
    end

    def period_monthly
      (@end_range - @start_range).to_i == @start_range.at_end_of_month.day - 1
    end

    def period_quarterly
      limits_date && @months == QUARTERLY && MONTHS_QUARTERLY.include?(@end_range.month)
    end

    def period_semesterly
      limits_date && @months == SEMESTERLY && MONTHS_SEMESTERLY.include?(@end_range.month)
    end

    def period_yearly
      limits_date && @months == YEARLY && @start_range.month == 1 && @end_range.month == 12
    end
  end
end
