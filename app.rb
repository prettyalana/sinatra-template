require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "geocoder"
require "google_places"
require "cgi"
require "sinatra/cookies"


# erb{:layout => false } allows you to change the layout of one or more of your erb files
# Remember, when fetching params you're fetching the name of the dynamic route ex 
# get(/:choices)
# params.fetch("choices")
# Remember instance variable names need to match when fetching the params

get("/") do
  quotes = ["Encourage yourself, believe in yourself, and love yourself. Never doubt who you are. ― Stephanie Lahart, Overcoming Life's Obstacles: Enlighten-Encourage-Empower", " The sun himself is weak when he first rises, and gathers strength and courage as the day gets on. — Charles Dickens, The Old Curiosity Shop", "Coming together is a beginning. Keeping together is progress. Working together is success. — Henry Ford", "When your dreams are bigger than the places you find yourself in, sometimes you need to seek out your own reminders that there is more. And there is always more waiting for you on the other side of fear. — Elaine Welteroth, More Than Enough: Claiming Space for Who You Are", "Cultivate an optimistic mind, use your imagination, always consider alternatives, and dare to believe that you can make possible what others think is impossible. ― Rodolfo Costa, Advice My Parents Gave Me: and Other Lessons I Learned from My Mistakes"]

@inspirational_quotes = quotes.sample
  erb(:homepage)
end

get("/:search") do
  api_key = ENV.fetch("GOOGLE_API_KEY")
  user_location = params.fetch("search-locations")
  filtered_location = user_location.gsub(" ", "%" )

  @search_location = params.fetch("search-locations")

  gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{filtered_location}&key=#{api_key}"

user_response = HTTP.get(gmaps_url)

raw_response = user_response.to_s

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")

first_results = results[0]

geo = first_results.fetch("geometry")

locator = geo.fetch("location")

@latitude = locator.fetch("lat")
@longitude = locator.fetch("lng")

  erb(:location , {:layout => false })
end

get("/:search/:search_results") do
  api_key = ENV.fetch("GOOGLE_API_KEY")
  @search_location = params.fetch("search-locations")
  @search_resource = params.fetch("resource")
  @lat = params.fetch("latitude")
  @lng = params.fetch("longitude")

 api_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=#{CGI.escape(@search_resource)}&location=#{@lat},#{@lng}&radius=1500&type=social+service+homeless&key=#{api_key}"

  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  @parsed_data = JSON.parse(raw_data_string)

  @results = @parsed_data.fetch("results").map{ |result| result.slice("name", "opening_hours", "photos", "rating") }

  erb(:results , {:layout => false })
end

# get("/additional_resources") do

# end


# api_key = ENV.fetch("GOOGLE_API_KEY")
#   api_url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJrTLr-GyuEmsRBfy61i59si0&fields=address_components&key=#{api_key}"


#   raw_data = HTTP.get(api_url)
#   raw_data_string = raw_data.to_s
#   parsed_data = JSON.parse(raw_data_string)
#   @keys = parsed_data.fetch("result")


# api_url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJrTLr-GyuEmsRBfy61i59si0&fields=address_components&key=#{api_key}"


  # raw_data = HTTP.get(api_url)
  # raw_data_string = raw_data.to_s
  # parsed_data = JSON.parse(raw_data_string)
  # @keys = parsed_data.fetch("result")


# @keys = parsed_data.fetch("candidates")

# user_location = "Chicago"

  # api_url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&input=Chicago&inputtype=textquery&key=#{api_key}"
  # api_url = "https://places.googleapis.com/v1/places/places:searchText?fields=addressComponents&key=#{api_key}
  
