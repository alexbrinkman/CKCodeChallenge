class PastController < ApplicationController
  before_filter :refresh_database

  def index
    count = params[:show] || 10
    @movies = Movie.order('box_office_ranking').limit(count)
  end
end
