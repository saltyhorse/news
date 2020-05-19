require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "imperial" # or metric, whatever you like
  key = "7961e44cb5fcd1a0c89c158ffd83bc8d" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"
  forecast = HTTParty.get(url).parsed_response.to_hash

  @current= forecast["current"]
  daily_temp= forecast ["daily"]
  @fiveday_temp = daily_temp[1,6]

  ### Get the news

  url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ddf0f244507c49d5adb66bfc95fb71e1"
  news = HTTParty.get(url).parsed_response.to_hash

  article_number = [0,20]
  @articles = news["articles"]

 #@top_articles = []
  #for source in article_number 
    #@top_articles<< "#{news["articles"][source]["source"]["name"]}"
  #end



  view 'news'

end
