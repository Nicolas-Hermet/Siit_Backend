require_relative 'additional_option'

class BabySeat
  def action
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
  end
end
