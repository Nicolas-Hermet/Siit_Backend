require_relative '../spec_helper'

RSpec.describe TransactionHandler do
  let(:car) do
    Car.new(
      id: 1,
      price_per_day: 2000,
      price_per_km: 10
    )
  end

  let(:rental) do
    Rental.new(
      id: 1,
      car: car,
      start_date: Date.new(2015, 07, 3),
      end_date: Date.new(2015, 07, 14),
      distance: 1000
    )
  end

  let(:commission_spliter) { CommissionSpliter.new(rental: rental) }

  describe '#handle' do
    context 'with default commission and repartition' do
      it 'generates correct transactions for all actors' do
        transactions = described_class.handle(rental: rental, commission_spliter: commission_spliter)

        expect(transactions).to contain_exactly(
          {
            who: :driver,
            type: :debit,
            amount: 27800
          },
          {
            who: :owner,
            type: :credit,
            amount: 19460.0
          },
          {
            who: :insurance,
            type: :credit,
            amount: 4170.0
          },
          {
            who: :assistance,
            type: :credit,
            amount: 12.0
          },
          {
            who: :drivy,
            type: :credit,
            amount: 4158.0
          }
        )
      end
    end
  end
end