require_relative '../spec_helper'

RSpec.describe GPS do
  describe '#action' do
    it 'returns the correct action for GPS' do
      expect(described_class.new.action).to eq(
        [
          {
            who: "owner",
            type: 'gps',
            amount: 5
          },
          {
            who: "driver",
            type: 'gps',
            amount: 5
          }
        ]
      )
    end
  end
end
