require_relative 'additional_option'

class TransactionHandler
  def initialize(rental:, commission_spliter:, options_for_rental: [])
    @rental = rental
    @options_for_rental = options_for_rental
    @commissions = commission_spliter.split
  end

  def self.handle(rental:, commission_spliter:, options_for_rental: [])
    new(rental:, commission_spliter:, options_for_rental:).handle
  end

  def actions
    @actions ||= [
      {
        who: :driver,
        type: :debit,
        amount: @rental.price
      },
      {
        who: :owner,
        type: :credit,
        amount: @rental.price - @commissions.values.sum,
      },
      {
        who: :insurance,
        type: :credit,
        amount: @commissions[:insurance_fee],
      },
      {
        who: :assistance,
        type: :credit,
        amount: @commissions[:assistance_fee],
      },
      {
        who: :drivy,
        type: :credit,
        amount: @commissions[:drivy_fee],
      }
    ]
  end

  def add_options
    @options_for_rental.each do |option|
      option_action = AdditionalOption.new(option['type'].to_sym).action
      option_action.each do |transaction|
        action = @actions.find { |action| action[:who] == transaction[:who].to_sym }
        action[:amount] += transaction[:amount]
      end
    end
  end

  def handle
    actions
    add_options
    {
      id: @rental.id,
      options: @options_for_rental.map{ |option| option['type'] },
      actions: @actions
    }
  end
end
