class PastController < ApplicationController
  before_filter :refresh_database

  def index
    count = params[:show] || 10 # todo: constant value for this?
    @movies = Movie.order('id').limit(count) #todo: convert to int?
    # todo: order by ranking, not id.
  end
end
