require 'rails_helper'

RSpec.describe Movie, :type => :model do

  before(:each) do
    @movie = FactoryGirl.build(:movie)
  end

  it 'is invalid when empty' do
    movie = Movie.new
    expect(movie.invalid?).to be true
  end

  it 'must have a title' do
    @movie.title = nil
    expect(@movie.invalid?).to be true

    @movie.title = 'Movie Title'
    expect(@movie.valid?).to be true
  end

  it 'must have a poster_url' do
    @movie.poster_url = nil
    expect(@movie.invalid?).to be true

    @movie.poster_url = 'http://'
    expect(@movie.valid?).to be true
  end

  it 'must have a year' do
    @movie.year = nil
    expect(@movie.invalid?).to be true

    @movie.year = 2014
    expect(@movie.valid?).to be true
  end

  it 'must have a mpaa_rating' do
    @movie.mpaa_rating = nil
    expect(@movie.invalid?).to be true

    @movie.mpaa_rating = 'PG'
    expect(@movie.valid?).to be true
  end

  it 'must have a critics_rating' do
    @movie.critics_rating = nil
    expect(@movie.invalid?).to be true

    @movie.critics_rating = 'Awesome'
    expect(@movie.valid?).to be true
  end

  it 'must have a critics_score between 0 and 100' do
    @movie.critics_score = nil
    expect(@movie.invalid?).to be true

    @movie.critics_score = 100
    expect(@movie.valid?).to be true

    @movie.critics_score = 101
    expect(@movie.valid?).to be false

    @movie.critics_score = -1
    expect(@movie.valid?).to be false
  end

  it 'must have a audience_rating' do
    @movie.audience_rating = nil
    expect(@movie.invalid?).to be true

    @movie.audience_rating = 'Awesome'
    expect(@movie.valid?).to be true
  end

  it 'must have a audience_score between 0 and 100' do
    @movie.audience_score = nil
    expect(@movie.invalid?).to be true

    @movie.audience_score = 100
    expect(@movie.valid?).to be true

    @movie.audience_score = 101
    expect(@movie.valid?).to be false

    @movie.audience_score = -1
    expect(@movie.valid?).to be false
  end

  it 'must have a movie_details_url' do
    @movie.movie_details_url = nil
    expect(@movie.invalid?).to be true

    @movie.movie_details_url = 'http:'
    expect(@movie.valid?).to be true
  end

  it 'must have a movie_reviews_url' do
    @movie.movie_reviews_url = nil
    expect(@movie.invalid?).to be true

    @movie.movie_reviews_url = 'http:'
    expect(@movie.valid?).to be true
  end

end
