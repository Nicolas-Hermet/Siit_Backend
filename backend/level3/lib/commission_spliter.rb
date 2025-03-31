class CommissionSpliter
  DEFAULT_REPARTITION = {
    insurance_fee: 0.5,
    assistance_fee: 1
  }.freeze

  DEFAULT_COMMISSION = 0.3

  def initialize(commission: DEFAULT_COMMISSION, rental: Rental.new, repartition: DEFAULT_REPARTITION)
    @commission = commission
    @repartition = repartition
    @number_of_days = rental.number_of_days
    @base = (commission * rental.price).to_i
  end

  attr_reader :base, :commission, :repartition, :number_of_days

  def split
    @commission_split ||= begin
      insurance_fee = (base * repartition[:insurance_fee]).to_f
      assistance_fee = (number_of_days * repartition[:assistance_fee]).to_f
      {
        insurance_fee: insurance_fee,
        assistance_fee: assistance_fee,
        drivy_fee: base - insurance_fee - assistance_fee
      }
    end
  end
end
