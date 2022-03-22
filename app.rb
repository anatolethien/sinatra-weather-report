require "sinatra"
require_relative "parser.rb"

get "/" do
  erb :index
end

post "/weather-report" do
  search = params["search"]
  location = get_location("https://nominatim.openstreetmap.org/search?q=#{search}&format=json")
  weather = get_weather("https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=#{location[:latitude]}&lon=#{location[:longitude]}")
  @city = location[:city]
  @country = location[:country]
  @temperature = weather[:temperature]
  erb :weather
end
