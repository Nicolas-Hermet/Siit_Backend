require_relative 'spec_helper'

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
    let(:expected_price) { 7_000 }

    it 'calculates price correctly for a short rental' do
      # 3 days * 2000 + 100 km * 10 = 6000 + 1000 = 7000
      expect(rental.price).to eq(expected_price)
    end

    context 'when the rental is longer than 1 day' do
      let(:start_date) { Date.new(2017, 12, 14) }
      let(:end_date) { Date.new(2017, 12, 18) }
      let(:distance) { 550 }
      let(:expected_price) { 15_500 }

      it 'calculates price correctly for a longer rental' do
        # 5 days * 2000 + 550 km * 10 = 10000 + 5500 = 15500
        expect(rental.price).to eq(expected_price)
      end
    end

    context 'when the car has a different price per day' do
      let(:car) { Car.new(id: 2, price_per_day: 3000, price_per_km: 15) }
      let(:distance) { 150 }
      let(:expected_price) { 11_250 }
      it 'calculates price correctly' do
        # 3 days * 3000 + 150 km * 15 = 9000 + 2250 = 11250
        expect(rental.price).to eq(expected_price)
      end
    end
  end
end
