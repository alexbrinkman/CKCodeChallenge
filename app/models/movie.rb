class Movie < ActiveRecord::Base
  validates_presence_of :title, :poster_url, :year, :mpaa_rating,
    :critics_rating, :critics_score, :audience_rating, :audience_score,
    :movie_details_url, :movie_reviews_url
  validates :critics_score, :inclusion => { :in => 0..100 }
  validates :audience_score, :inclusion => { :in => 0..100 }
end
