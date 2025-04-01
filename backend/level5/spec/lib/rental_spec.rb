require_relative '../spec_helper'

RSpec.describe Rental do
  let(:car) { Car.new(id: 1, price_per_day: 2_000, price_per_km: 10) }
  let(:start_date) { Date.new(2017, 12, 8) }
  let(:end_date) { Date.new(2017, 12, 10) }
  let(:distance) { 100 }
  let(:rental) { Rental.new(id: 1, car: car, start_date: start_date, end_date: end_date, distance: distance) }

  describe '#initialize' do
    it 'creates a rental with correct attributes' do
      expect(rental.id).to eq(1)

      expect(rental.id).to eq(1)
      expect(rental.car).to eq(car)
      expect(rental.start_date).to eq(Date.new(2017, 12, 8))
      expect(rental.end_date).to eq(Date.new(2017, 12, 10))
      expect(rental.distance).to eq(100)
    end
  end

  describe '#price' do
    let(:expected_price) { 6_600 }

    it 'calculates price correctly for a short rental' do
      # 1 day * 2000 + 2 days * 1800 + 100 km * 10 = 5600 + 1000 = 6600
      expect(rental.price).to eq(expected_price)
    end

    context 'when the rental is longer than 1 day' do
      let(:start_date) { Date.new(2017, 12, 14) }
      let(:end_date) { Date.new(2017, 12, 18) }
      let(:distance) { 550 }
      let(:expected_price) { 14_300 }

      it 'calculates price correctly for a longer rental' do
        # 1 day * 2000 + 3 days * 1800 + 1 day * 1400 + 550 km * 10 = 8800 + 5500 = 14300
        expect(rental.price).to eq(expected_price)
      end
    end

    context 'when the car has a different price per day' do
      let(:car) { Car.new(id: 2, price_per_day: 3000, price_per_km: 15) }
      let(:distance) { 150 }
      let(:expected_price) { 10_650 }
      it 'calculates price correctly' do
        # 1 day * 3000 + 2 day * 2700 + 150 km * 15 = 8400 + 2250 = 10650
        expect(rental.price).to eq(expected_price)
      end
    end
  end
end
