require_relative 'lib/car'
require_relative 'lib/rental'
require_relative 'lib/price_decreaser'
require_relative 'lib/commission_spliter'
require_relative 'lib/additional_option'
require_relative 'lib/transaction_handler'
require 'json'
require 'date'

def perform
  input_file = File.read(File.join(__dir__, 'data', 'input.json'))
  input_data = JSON.parse(input_file)

  cars = input_data['cars'].map do |car_data|
    car_params = {
      id: car_data['id'],
      price_per_day: car_data['price_per_day'],
      price_per_km: car_data['price_per_km']
    }
    [car_data['id'], Car.new(**car_params)]
  end.to_h

  options_for_rental = input_data['options']
                       .group_by { |option| option['rental_id'] }

  rentals = input_data['rentals'].map do |rental_data|
    car = cars[rental_data['car_id']]
    rental = Rental.new(
      id: rental_data['id'],
      car: car,
      start_date: Date.parse(rental_data['start_date']),
      end_date: Date.parse(rental_data['end_date']),
      distance: rental_data['distance']
    )

    TransactionHandler.handle(
        rental: rental,
        options_for_rental: options_for_rental[rental.id] || [],
        commission_spliter: CommissionSpliter.new(
          rental: rental
        )
      )
  end

  output = { rentals: rentals }

  File.write(
    File.join(__dir__, 'data', 'output.json'),
    JSON.pretty_generate(output)
  )
end

perform
