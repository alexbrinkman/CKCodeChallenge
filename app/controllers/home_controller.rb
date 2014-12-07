class HomeController < ApplicationController

  # todo: shouldn't need this???
  include RottenTomatoes

  def index
    debugger
    Rotten.api_key = 'bbbv6grs52qsvyerxqstj7zr'
    @movies = RottenList.find(type: 'in_theaters', limit: 5)
    puts @movies.to_json
  end
end
