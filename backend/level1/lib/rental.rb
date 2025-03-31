class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance, :distance_price, :time_price, :number_of_days

  def initialize(id:, car:, start_date:, end_date:, distance:)
    @id = id
    @car = car
    @start_date = start_date
    @end_date = end_date
    @distance = distance
    @distance_price = distance * car.price_per_km
    @time_price = number_of_days * car.price_per_day
    @number_of_days = number_of_days
  end

  def price
    time_price + distance_price
  end

  private

  def number_of_days
    (end_date - start_date).to_i + 1
  end
end
