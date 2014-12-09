class FutureController < ApplicationController
  def index
    #todo: check for stale database.
    #todo: order by ranking, not id.
    movies = Movie.order('id').limit(5) #todo: constants?
    titles = movies.map {|item| item[:title]}
    @projections = ProjectionEngine.project(titles)
  end
end
