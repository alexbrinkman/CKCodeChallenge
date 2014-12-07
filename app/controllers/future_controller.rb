class FutureController < ApplicationController
  def index
    @movies = Movie.order('critics_score desc').limit(5) #todo: convert to int?
  end
end
