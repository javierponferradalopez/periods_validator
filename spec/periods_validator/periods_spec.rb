require 'spec_helper'

RSpec.describe PeriodsValidator::Periods do
  let(:options) do
    {
      monthly: {
        start_range: Date.new(2015, 1, 1), end_range: Date.new(2015, 1, 31), periods: %i[monthly]
      },
      quarterly: {
        start_range: Date.new(2015, 4, 1), end_range: Date.new(2015, 6, 30), periods: %i[quarterly]
      },
      semesterly: {
        start_range: Date.new(2015, 1, 1), end_range: Date.new(2015, 6, 30), periods: %i[semesterly]
      },
      yearly: {
        start_range: Date.new(2015, 1, 1), end_range: Date.new(2015, 12, 31), periods: %i[yearly]
      }
    }
  end

  context 'when exists periods' do
    describe 'One Period' do
      %i[monthly quarterly semesterly yearly].each do |period|
        context "when period is #{period}" do
          context 'when range is valid' do
            before do
              @validator = PeriodsValidator::Periods.new(options[period])
              @validator.valid?
            end

            it 'hides errors' do
              expect(@validator.error).to be_nil
            end
          end

          context "when range isn\'t #{period}" do
            let(:option_invalid) do
              option = options[period]
              option[:end_range] = option[:end_range].next_month
              option
            end

            before do
              @validator = PeriodsValidator::Periods.new(option_invalid)
              @validator.valid?
            end

            it 'shows errors' do
              expect(@validator.error).to eq(:invalid_period)
            end
          end

          context 'when end_range isn\'t end day of month' do
            let(:option_invalid) do
              option = options[period]
              option[:end_range] = option[:end_range].beginning_of_month
              option
            end

            before do
              @validator = PeriodsValidator::Periods.new(option_invalid)
              @validator.valid?
            end

            it 'shows errors' do
              expect(@validator.error).to eq(:invalid_period)
            end
          end
        end
      end
    end

    describe 'Cases complex' do
      context 'when is yearly and quarterly' do
        before do
          @validator = PeriodsValidator::Periods.new(start_range: Date.new(2019, 1, 1),
                                           end_range: Date.new(2020, 3, 31),
                                           periods: %i[quarterly yearly])
          @validator.valid?
        end

        it 'shows errors' do
          expect(@validator.error).to eq(:invalid_period)
        end
      end

      context 'when yearly isn\'t period real' do
        before do
          @validator = PeriodsValidator::Periods.new(start_range: Date.new(2015, 2, 1),
                                                     end_range: Date.new(2016, 1, 31),
                                                     periods: %i[yearly])
          @validator.valid?
        end

        it 'shows errors' do
          expect(@validator.error).to eq(:invalid_period)
        end
      end

      context 'when quarterly isn\'t period real' do
        before do
          @validator = PeriodsValidator::Periods.new(start_range: Date.new(2015, 2, 1),
                                                     end_range: Date.new(2015, 4, 30),
                                                     periods: %i[yearly])
          @validator.valid?
        end

        it 'shows errors' do
          expect(@validator.error).to eq(:invalid_period)
        end
      end

      context 'when semesterly isn\'t period real' do
        before do
          @validator = PeriodsValidator::Periods.new(start_range: Date.new(2015, 2, 1),
                                                     end_range: Date.new(2015, 7, 31),
                                                     periods: %i[yearly])
          @validator.valid?
        end

        it 'shows errors' do
          expect(@validator.error).to eq(:invalid_period)
        end
      end
    end

    describe 'More Periods' do
      context 'when range is valid' do
        let(:option) do
          {start_range: Date.new(2015, 1, 1), end_range: Date.new(2015, 1, 31),
           periods: %i[quarterly monthly]}
        end

        before do
          @validator = PeriodsValidator::Periods.new(option)
          @validator.valid?
        end

        it 'hides errors' do
          expect(@validator.error).to be_nil
        end
      end

      context 'when range is invalid' do
        let(:option_invalid) do
          {start_range: Date.new(2015, 2, 3), end_range: Date.new(2015, 2, 1),
           periods: %i[quarterly monthly]}
        end

        before do
          @validator = PeriodsValidator::Periods.new(option_invalid)
          @validator.valid?
        end

        it 'shows errors' do
          expect(@validator.error).to eq(:invalid_period)
        end
      end
    end
  end

  context 'when period defined in periods is invalid' do
    context 'when periods not exists' do
      before do
        option_invalid = {start_range: Date.new(2015, 1, 1), end_range: Date.new(2015, 1, 31),
                          periods: %i[invalid]}

        @validator = PeriodsValidator::Periods.new(option_invalid)
        @validator.valid?
      end

      it 'shows errors' do
        expect(@validator.error).to eq(:invalid_define_period)
      end
    end

    context 'when periods is empty' do
      before do
        option_invalid = {start_range: Date.new(2015, 1, 1), end_range: Date.new(2015, 1, 31),
                          periods: %i[]}

        @validator = PeriodsValidator::Periods.new(option_invalid)
        @validator.valid?
      end

      it 'shows errors' do
        expect(@validator.error).to eq(:invalid_define_period)
      end
    end
  end
end
