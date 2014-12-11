class PastController < ApplicationController
  before_filter :refresh_database

  def index
    count = validate_limit(params[:show])
    @movies = Movie.order('box_office_ranking').limit(count)
    @last_saturday = ProjectionEngine.last_saturday
  end

  private

  def validate_limit(limit)
    return 10 if limit.nil?
    return 10 if limit.to_i < 1 || limit.to_i > 25
    limit
  end
end
