require "httparty"

$user_agent = "curl"

def get_location(uri)
  response = HTTParty.get(uri, headers: {"User-Agent": $user_agent}).parsed_response
  return {
    "city": response.first["display_name"].split(", ").first,
    "country": response.first["display_name"].split(", ").last,
    "latitude": response.first["lat"],
    "longitude": response.first["lon"]
  }
end

def get_weather(uri)
  response = HTTParty.get(uri, headers: {"User-Agent": $user_agent}).parsed_response
  return {
    "temperature": response["properties"]["timeseries"].first["data"]["instant"]["details"]["air_temperature"],
    "condition": response["properties"]["timeseries"].first["data"]["next_1_hours"]["summary"]["symbol_code"],
    "illustration": illustrate(response["properties"]["timeseries"].first["data"]["next_1_hours"]["summary"]["symbol_code"])
  }
end

def illustrate(condition)
  sunny = ["fair_day", "clearsky_day"]
  rainy = ["rain", "lightrain", "heavyrain"]
  snowy = ["snow", "lightsnow", "heavysnow"]
  cloudy = ["cloudy", "partlycloudy_day", "fog"]
  nightly = ["fair_night", "clearsky_night", "partlycloudy_night"]
  if sunny.include?(condition)
    return "day"
  elsif rainy.include?(condition)
    return "rain"
  elsif snowy.include?(condition)
    return "snow"
  elsif cloudy.include?(condition)
    return "day"
  elsif nightly.include?(condition)
    return "night"
  else
    return condition
  end
end
