require_relative 'gps'
require_relative 'baby_seat'
require_relative 'additional_insurance'

class AdditionalOption
  AUTHORIZED_OPTIONS = {
    gps: GPS,
    baby_seat: BabySeat,
    additional_insurance: AdditionalInsurance
  }.freeze

  def initialize(type)
    raise ArgumentError, "Unknown option type: #{type}" unless AUTHORIZED_OPTIONS[type.to_sym]

    @type = type
  end

  def action
    AUTHORIZED_OPTIONS[@type].new().action
  end
end
