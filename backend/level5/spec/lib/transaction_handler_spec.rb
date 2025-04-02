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
        result = described_class.handle(rental: rental, commission_spliter: commission_spliter)

        expect(result).to eq(
          {
            id: 1,
            options: [],
            actions: [
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
            ]
          }
        )
      end
    end

    context 'with options' do
      let(:options) do
        [
          { 'type' => 'gps' },
          { 'type' => 'baby_seat' }
        ]
      end

      it 'includes options in the result and adjusts amounts accordingly' do
        result = described_class.handle(
          rental: rental,
          commission_spliter: commission_spliter,
          options_for_rental: options
        )

        expect(result[:options]).to eq(%w[gps baby_seat])
        expect(result[:actions]).to include(
            {
              who: :driver,
              type: :debit,
              amount: 27800 + (2.0 + 5.0) * 12
            }
          )
      end
    end
  end
end
