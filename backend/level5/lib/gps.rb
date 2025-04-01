require_relative 'additional_option'

class GPS
  def action
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
  end
end
