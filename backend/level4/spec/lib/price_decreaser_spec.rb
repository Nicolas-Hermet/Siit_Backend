require_relative '../spec_helper'

RSpec.describe PriceDecreaser do
  let(:base_price) { rand(100..1000) }
  subject(:price_decreaser) { described_class.new }

  describe "Rules" do
    rules = [
      { days: 0, discount: 0.0 },
      { days: 1, discount: 0.1 },
      { days: 4, discount: 0.3 },
      { days: 10, discount: 0.5 }
    ]

    rules.each_with_index do |rule, index|
      it "is decreasing price by #{rule[:discount]} after #{rule[:days]} days" do
        expect(PriceDecreaser::DEFAULT_RULES[index]).to eq(rule)
      end
    end
  end

  describe '#decreased_price' do
    context 'when rental duration is 1 day or less' do
      it 'returns the base price' do
        expect(price_decreaser.decreased_price(base_price, 1)).to eq(base_price)
      end
    end

    context 'when rental duration is 3 days' do
      let(:expected_price) { (base_price + (base_price * 0.9 * 2)).to_i }

      it 'applies 10% discount for the last 2 days' do
        expect(price_decreaser.decreased_price(base_price, 3)).to eq(expected_price)
      end
    end

    context 'when rental duration is 7 days' do
      # Days 1: base_price
      # Days 2-4: base_price * 0.9 each
      # Days 5-7: base_price * 0.7 each
      let(:expected_price) { (base_price + (base_price * 0.9 * 3) + (base_price * 0.7 * 3)).to_i }

      it 'applies correct discounts for each period' do
        expect(price_decreaser.decreased_price(base_price, 7)).to eq(expected_price)
      end
    end

    context 'when rental duration is more than 10 days' do
      # Days 1: base_price
      # Days 2-4: base_price * 0.9 each
      # Days 5-10: base_price * 0.7 each
      # Days 11-12: base_price * 0.5 each
      let(:expected_price) { (base_price + (base_price * 0.9 * 3) + (base_price * 0.7 * 6) + (base_price * 0.5 * 2)).to_i }

      it 'applies all discount levels' do
        expect(price_decreaser.decreased_price(base_price, 12)).to eq(expected_price)
      end
    end
  end

  describe '#update_rules' do
    let(:new_rules) { [
        { days: 2, discount: 0.2 },
        { days: 5, discount: 0.4 }
      ]
    }
    # for 6 days
    # Day 1-2: base_price
    # Day 3-5: base_price * 0.8 each
    # Day 6: base_price * 0.6
    let(:expected_price) { (base_price * 2 + (base_price * 0.8 * 3) + (base_price * 0.6 )).to_i }
    subject(:price_decreaser) { described_class.new(rules: new_rules) }
    let(:base_price) { 100 }

    it 'allows updating the discount rules' do
      expect(price_decreaser.decreased_price(base_price, 6)).to eq(expected_price)
    end
  end
end
