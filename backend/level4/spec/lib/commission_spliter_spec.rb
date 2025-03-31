require_relative '../spec_helper'

RSpec.describe CommissionSpliter do
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
      start_date: Date.new(2017, 12, 8),
      end_date: Date.new(2017, 12, 8),
      distance: 100
    )
  end

  let(:commission_spliter) { described_class.new(rental: rental) }

  describe '#split' do
    context 'with default commission and repartition' do
      it 'splits the commission correctly' do
        split = commission_spliter.split

        expect(split).to eq({
          insurance_fee: 450,
          assistance_fee: 1.0,
          drivy_fee: 449
        })
      end
    end

    context 'with custom commission rate' do
      it 'splits the commission correctly'
    end

    context 'with custom repartition' do
      it 'splits the commission correctly'
    end
  end
end
