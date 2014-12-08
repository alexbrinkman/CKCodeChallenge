class PastController < ApplicationController
  def index
    count = params[:show] || 10 # todo: constant value for this?
    @movies = Movie.order('id').limit(count) #todo: convert to int?
  end
end
