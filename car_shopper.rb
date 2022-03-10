# frozen_string_literal: true

require 'httparty'
require 'nokogiri'
require 'pp'

def convert_price(price)
  price.gsub('$', '').gsub(',', '').to_i
end

def car_shopper
  response = HTTParty.get('https://code.evgenyrahman.com/rubycourse/carlist.html')
  parsed_html = Nokogiri::HTML(response.body)

  car_listings = parsed_html.css('.card.car')

  # pp car_listings.first

  #   car_listings.each do |each_car|
  #     pp each_car.css('.make').text
  #     pp each_car.css('.year').text
  #     pp each_car.css('.price').text
  #     pp each_car.css('.star.rating').attribute("data-rating").value
  #   end

  cars = car_listings.map do |each_car|
    {
      make: each_car.css('.make').text,
      year: each_car.css('.year').text.to_i,
      price: convert_price(each_car.css('.price').text),
      rating: each_car.css('.star.rating').attribute('data-rating').value.to_i
    }
  end

  cars.select! do |car|
    (car[:price] < 30_000) && (car[:year] > 2014) && (car[:rating] > 3)
  end

  # pp cars.to_json

  File.open('car_listings.json', 'wb') do |f|
    f << cars.to_json
  end
  puts 'Result were written to file !'

  # puts 'Welcome to the shopper!'

  # puts parsed_html
end

car_shopper 



#" Welcome "
