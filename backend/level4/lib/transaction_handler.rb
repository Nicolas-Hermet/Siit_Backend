class TransactionHandler
  def initialize(rental:, commission_spliter:)
    @rental = rental
    @commissions = commission_spliter.split
  end

  def self.handle(rental:, commission_spliter:)
    new(rental: rental, commission_spliter: commission_spliter).handle
  end

  def handle
    [
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
end
