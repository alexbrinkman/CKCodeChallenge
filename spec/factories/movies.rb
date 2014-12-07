FactoryGirl.define do
  factory :movie do
    title 'Movie'
    poster_url 'http://content8.flixster.com/movie/11/16/39/11163966_tmb.jpg'
    year 2011
    mpaa_rating 'PG-13'
    critics_rating 'Certified Fresh'
    critics_score 97
    audience_rating 'Upright'
    audience_score 93
    movie_details_url 'http://www.rottentomatoes.com/m/good_will_hunting/'
    movie_reviews_url 'http://www.rottentomatoes.com/m/good_will_hunting/reviews/?type=top_critics'
  end
end