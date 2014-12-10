class FutureController < ApplicationController
  before_filter :refresh_database

  def index
    movies = Movie.order('box_office_ranking').limit(5)
    titles = movies.map {|item| item[:title]}
    @projections = ProjectionEngine.project(titles)
  end
end
