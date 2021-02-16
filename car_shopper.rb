require 'httparty'
require 'nokogiri'
require 'pp'

def car_shopper
  response = HTTParty.get('https://code.evgenyrahman.com/rubycourse/carlist.html')
  parsed_html = Nokogiri::HTML(response.body)

  car_listings = parsed_html.css('.card.car')

  #pp car_listings.first
=begin
  car_listings.each do |each_car|
    pp each_car.css('.make').text 
    pp each_car.css('.year').text
    pp each_car.css('.price').text
    pp each_car.css('.star.rating').attribute("data-rating").value 
  end
=end

car_listings.each do |each_car|
  car = {
      make: each_car.css('.make').text, 
      year: each_car.css('.year').text,
      price: each_car.css('.price').text,
      rating: each_car.css('.star.rating').attribute("data-rating").value 
  }
  pp car 
end
  #puts 'Welcome to the shopper!'

  #puts parsed_html
end

car_shopper