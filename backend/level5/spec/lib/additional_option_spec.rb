require_relative '../spec_helper'

AUTHORIZED_OPTIONS = {
  gps: GPS,
  baby_seat: BabySeat,
  additional_insurance: AdditionalInsurance
}.freeze

RSpec.describe AdditionalOption do
  describe '#action' do
    %i[gps baby_seat additional_insurance].each do |type|
      it "delegates to the correct class for #{type}" do
        expect(AdditionalOption.new(type).action).to eq(AUTHORIZED_OPTIONS[type].new.action)
      end
    end
  end
end
