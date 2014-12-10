class FutureController < ApplicationController
  before_filter :refresh_database

  def index
    #todo: order by ranking, not id.
    movies = Movie.order('id').limit(5) #todo: constants?
    titles = movies.map {|item| item[:title]}
    @projections = ProjectionEngine.project(titles)
  end
end
