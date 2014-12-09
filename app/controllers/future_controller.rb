class FutureController < ApplicationController
  def index
    #todo: check for stale database.
    #todo: order by ranking, not id.
    movie_list = Movie.order('id').limit(5) #todo: constants?
    projections = ProjectionEngine.project(movie_list)
    @weeks = projections[:weeks]
    @movies = projections[:movies]
  end
end
