require 'pry'
class PriceDecreaser
  DEFAULT_RULES = [
    { days: 0, discount: 0.0 },
    { days: 1, discount: 0.10 },
    { days: 4, discount: 0.30 },
    { days: 10, discount: 0.50 }
  ].freeze

  attr_reader :rules

  def initialize(rules: DEFAULT_RULES)
    rules = rules.any? { |rule| rule[:days].zero? } ? rules : rules + [{ days: 0, discount: 0.0 }]
    @rules = rules.sort_by { |rule| rule[:days] }
  end

  def decreased_price(base_price, number_of_days)
    return base_price if number_of_days <= 1

    total_price = 0
    remaining_days = number_of_days

    rules.each_with_index do |rule, index|
      next if remaining_days <= 0


      next_rule = rules[index + 1]
      days_in_this_tier = if next_rule
                            [remaining_days, next_rule[:days] - rule[:days]].min
                          else
                            remaining_days
                          end

      if days_in_this_tier.positive?
        total_price += base_price * (1 - rule[:discount]) * days_in_this_tier
        remaining_days -= days_in_this_tier
      end
    end

    total_price.to_i
  end
end
