class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance, :distance_price, :time_price, :number_of_days, :price_decreaser

  def initialize(id:, car:, start_date:, end_date:, distance:, price_decreaser: PriceDecreaser.new)
    @id = id
    @car = car
    @start_date = start_date
    @end_date = end_date
    @distance = distance
    @distance_price = distance * car.price_per_km
    @number_of_days = (@end_date - @start_date).to_i + 1
    @price_decreaser = price_decreaser
  end

  def time_price
    @time_price ||= price_decreaser.decreased_price(car.price_per_day, number_of_days)
  end

  def price
    time_price + distance_price
  end
end
