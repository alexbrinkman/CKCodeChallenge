class PastController < ApplicationController
  def index
    # todo: check for stale database
    count = params[:show] || 10 # todo: constant value for this?
    @movies = Movie.order('id').limit(count) #todo: convert to int?
    # todo: order by ranking, not id.
  end
end
