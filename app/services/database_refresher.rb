require 'builder'
require 'uri'
require 'net/http'

class DatabaseRefresher

  def self.refresh(force = false)
    log 'Checking for the need to refresh database.'
    if force || refresh_cache?
      log 'The movie cache has expired, calling RottenTomatoes api.'
      movies = call_api
      Movie.destroy_all
      movies.each_with_index do |movie, index|
        new_movie = Movie.new
        new_movie.box_office_ranking = index + 1
        new_movie.title = movie['title']
        new_movie.poster_url = movie['posters']['thumbnail']
        new_movie.year = movie['year']
        new_movie.mpaa_rating = movie['mpaa_rating']
        new_movie.critics_rating = movie['ratings']['critics_rating']
        new_movie.critics_score = movie['ratings']['critics_score']
        new_movie.audience_rating = movie['ratings']['audience_rating']
        new_movie.audience_score = movie['ratings']['audience_score']
        new_movie.movie_details_url = movie['links']['alternate']
        new_movie.movie_reviews_url = movie['links']['reviews']
        new_movie.save
        # todo: error handling
      end
      log 'The movie cache was sucessfully refreshed.'
    else
      log 'The movie cache is still valid, database was not refreshed.'
    end
  end

  def self.call_api
    uri = URI(RT_CONSTANTS['callable_uri'])
    response = Net::HTTP.get(uri)
    ApiCall.create(source: 'web_refresh', status: 200) #todo: what if it fails?
    movie_hash = JSON.parse(response)
    movie_hash['movies']
  end

  def self.refresh_cache?
    return true if Movie.count < RT_CONSTANTS['limit']
    return true if expired_cache?
    false
  end

  private

  def self.expired_cache?
    minutes_to_cache = RT_CONSTANTS['minutes_to_cache'].to_i
    last_successful_call = ApiCall.where(status: 200).last
    if last_successful_call.nil? || last_successful_call.created_at < Time.zone.now - minutes_to_cache.minutes
      true
    else
      false
    end
  end

  def self.log(message)
    Rails.logger.tagged('Database Refresh') { Rails.logger.info message}
  end

end