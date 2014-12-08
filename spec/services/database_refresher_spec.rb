require 'rails_helper'
require 'spec_helper'

RSpec.describe DatabaseRefresher do

  # todo: constants
  ROTTEN_TOMATOES_URI = 'http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=bbbv6grs52qsvyerxqstj7zr&limit=25'

  context '.refresh' do

    before(:each) do
      stub_request(:get, ROTTEN_TOMATOES_URI)
        .to_return(body: File.new('./spec/support/sample_response.json'), status: 200)
    end

    it 'should clear and populate the database with 25 movies' do
      DatabaseRefresher.stub(:refresh_cache?).and_return(true)
      Movie.delete_all # Make sure we are at 0 to know that the count changed.
      expect{ DatabaseRefresher.refresh }.to change{ Movie.count }.from(0).to(25)
    end

    it 'should not refresh the database if it has been less than the cached amount of time' do
      DatabaseRefresher.stub(:refresh_cache?).and_return(false)
      expect{ DatabaseRefresher.refresh }.not_to change{ Movie.count }
    end

  end

  context '.refresh_cache' do

    before(:each) do
      Timecop.freeze(Time.zone.now)
      FactoryGirl.create(:api_call, created_at: Time.zone.now)
    end

    after(:each) do
      Timecop.return
      Movie.delete_all
    end

    it 'should not refresh cache if less than allowed timeframe' do
      30.times {|i| FactoryGirl.create(:movie, title: "Movie#{i}")}
      expect(DatabaseRefresher.refresh_cache?).to be false
    end

    it 'should refresh cache if more than allowed timeframe' do
      Timecop.travel(Time.zone.now + 1.hour)
      expect(DatabaseRefresher.refresh_cache?).to be true
    end

    it 'should refresh cache there are no movies in the database' do
      expect(DatabaseRefresher.refresh_cache?).to be true
    end
  end

end