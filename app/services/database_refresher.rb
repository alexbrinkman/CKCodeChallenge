require 'builder'
require 'uri'
require 'net/http'

class DatabaseRefresher

  def self.refresh(force = false, source = :web)
    log 'Checking for the need to refresh database.'
    if force || refresh_cache?
      log 'The movie cache has expired, calling RottenTomatoes api.'
      movies = call_api(source)
      if movies.nil?
        log 'The API call did not return any results, database not refreshed.'
      else
        Movie.destroy_all
        load_movies(movies)
      end
      log 'The movie cache was sucessfully refreshed.'
    else
      log 'The movie cache is still valid, database was not refreshed.'
    end
  end

  def self.call_api(source)
    response = HTTParty.get(RT_CONSTANTS['callable_uri'])
    ApiCall.create(source: source, status: response.code)
    movie_hash = JSON.parse(response)
    movie_hash['movies']
  end

  def self.refresh_cache?
    return true if Movie.count < RT_CONSTANTS['limit']
    return true if expired_cache?
    false
  end

  private

  def self.load_movies(movies)
    movies.each_with_index do |m, index|
      movie = Movie.new
      movie.box_office_ranking = index + 1
      movie.title = m['title']
      movie.poster_url = m['posters']['thumbnail']
      movie.year = m['year']
      movie.mpaa_rating = m['mpaa_rating']
      movie.critics_rating = m['ratings']['critics_rating']
      movie.critics_score = m['ratings']['critics_score']
      movie.audience_rating = m['ratings']['audience_rating']
      movie.audience_score = m['ratings']['audience_score']
      movie.movie_details_url = m['links']['alternate']
      movie.movie_reviews_url = m['links']['reviews']
      if movie.save
        log "Loaded #{movie.title}"
      else
        log "Unable to load #{movie.title}"
      end
    end
  end

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
    Rails.logger.tagged('Database Refresh') { Rails.logger.info "#{Time.zone.now}: #{message}"}
  end

end