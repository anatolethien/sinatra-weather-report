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
    "temperature": response["properties"]["timeseries"].first["data"]["instant"]["details"]["air_temperature"]
  }
end
