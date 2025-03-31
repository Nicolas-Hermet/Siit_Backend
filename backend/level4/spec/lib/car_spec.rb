require_relative '../spec_helper'

RSpec.describe Car do
  describe '#initialize' do
    let(:random_id) { rand(1..99) }
    let(:random_price_per_day) { rand(100..1000) }
    let(:random_price_per_km) { rand(1..10) }

    it 'creates a car with correct attributes' do
      car = Car.new(id: random_id, price_per_day: random_price_per_day, price_per_km: random_price_per_km)

      expect(car.id).to eq(random_id)
      expect(car.price_per_day).to eq(random_price_per_day)
      expect(car.price_per_km).to eq(random_price_per_km)
    end
  end
end
