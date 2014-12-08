require 'builder'
require 'uri'
require 'net/http'

class DatabaseRefresher

  def self.refresh
    puts 'Refreshing movies'
    debugger
    if refresh_cache?
      puts 'The movie cache is expired, calling RottenTomatoes api.'
      movies = call_api
      Movie.destroy_all
      movies.each do |movie|
        # todo: add ranking
        new_movie = Movie.new
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
    else
      puts 'The movie cache is still valid, database is valid.'
    end
  end

  def self.call_api
    uri = URI('http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=bbbv6grs52qsvyerxqstj7zr&limit=25')
    response = Net::HTTP.get(uri)
    movie_hash = JSON.parse(response)
    movie_hash['movies']
  end

  def self.refresh_cache?
    #todo: can this be cleaner?
    return true if Movie.count < 25 #todo: change this to constant
    last_successful_call = ApiCall.where(status: 200).last
    if !last_successful_call.nil? && last_successful_call.created_at < Time.zone.now - 1.hour
      return true
    else
      return false
    end
  end

end