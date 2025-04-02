require_relative 'additional_option'

class AdditionalInsurance
  def action
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
  end
end
