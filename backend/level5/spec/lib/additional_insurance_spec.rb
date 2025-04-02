require_relative '../spec_helper'

RSpec.describe AdditionalInsurance do
  describe '#action' do
    it 'returns the correct action for additional insurance' do
      expect(described_class.new.action).to eq(
        [
          {
            who: "drivy",
            type: "additional_insurance",
            amount: 10
          },
          {
            who: 'driver',
            type: "additional_insurance",
            amount: 10
          }
        ]
      )
    end
  end
end