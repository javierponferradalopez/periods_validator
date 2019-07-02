# periods_validator
[![Build Status](https://travis-ci.org/jponferrada26/periods_validator.svg?branch=master)](https://travis-ci.org/jponferrada26/periods_validator)
#### Gem used to validate periods between a range of dates.

The periods allowed are the following:
- monthly
- quarterly
- semesterly
- yearly

These periods start from the first day of the month corresponding to the first date, until the last day of the month which corresponds to the last date.

For now, the models in which this validation is used must have the fields:
- start_range
- end_range

## Installation
Add this line to your application's Gemfile:
```ruby
gem 'periods_validator'
```
## Examples
```ruby
class Model < ApplicationRecord
	validates :start_range, presence: true, periods: %i[monthly yearly]
	validates :end_range, presence: true
end
```
## Errors
The validator can return different errors depending on the data entered or the periods indicated by the developer.

There are several:
- invalid_define_period:  It occurs when the developer has not indicated a period allowed by the validator. For example:
```ruby
validates :start_range, periods: %i[ other_period ]
# ---- or ----
validates :start_range, periods: %i[]
```
- invalid_period:  It occurs when the date of start_range or end_range are not filled or when the range formed by both dates does not match any required period. For example:
```ruby
validates :start_range, periods: %i[ monthly ]
# start_range -> 01/01/2015
# end_range -> 01/12/2015 / or nil
```
