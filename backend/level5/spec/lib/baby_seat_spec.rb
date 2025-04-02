require_relative '../spec_helper'

RSpec.describe BabySeat do
  describe '#action' do
    it 'returns the correct action for baby seat' do
      expect(described_class.new.action).to eq(
        [
          {
            who: "owner",
            type: "baby_seat",
            amount: 2
          },
          {
            who: "driver",
            type: "baby_seat",
            amount: 2
          }
        ]
      )
    end
  end
end
