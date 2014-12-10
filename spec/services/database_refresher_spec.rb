require 'rails_helper'
require 'spec_helper'

RSpec.describe DatabaseRefresher do

  context '.refresh' do

    before(:each) do
      stub_request(:get, RT_CONSTANTS['callable_uri'])
        .to_return(body: File.new('./spec/support/sample_response.json'), status: 200)
    end

    it 'should clear and populate the database with 25 movies' do
      DatabaseRefresher.stub(:refresh_cache?).and_return(true)
      Movie.delete_all # Make sure we are at 0 to know that the count changed.
      expect{ DatabaseRefresher.refresh }.to change{ Movie.count }.from(0).to(25)
    end

    it 'should write a new entry to the api_calls table with success and a timestamp' do
      DatabaseRefresher.stub(:refresh_cache?).and_return(true)
      Movie.delete_all # Make sure we are at 0 to know that the count changed.
      expect{ DatabaseRefresher.refresh }.to change{ ApiCall.count }.by(1)
    end

    it 'should not refresh the database if it has been less than the cached amount of time' do
      DatabaseRefresher.stub(:refresh_cache?).and_return(false)
      expect{ DatabaseRefresher.refresh }.not_to change{ Movie.count }
      expect{ DatabaseRefresher.refresh }.not_to change{ ApiCall.count }
    end

    it 'should refresh the database if the force flag is set to true' do
      expect(DatabaseRefresher.refresh true).to be true
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
      minutes_to_cache = RT_CONSTANTS['minutes_to_cache'].to_i
      30.times {|i| FactoryGirl.create(:movie, title: "Movie#{i}")}
      Timecop.travel(Time.zone.now + minutes_to_cache.minutes - 1.minute)
      expect(DatabaseRefresher.refresh_cache?).to be false
    end

    it 'should refresh cache if more than allowed timeframe' do
      minutes_to_cache = RT_CONSTANTS['minutes_to_cache'].to_i
      30.times {|i| FactoryGirl.create(:movie, title: "Movie#{i}")}
      Timecop.travel(Time.zone.now + minutes_to_cache.minutes + 1.minute)
      expect(DatabaseRefresher.refresh_cache?).to be true
    end

    it 'should refresh cache if there are no movies in the database' do
      expect(DatabaseRefresher.refresh_cache?).to be true
    end

    it 'should refresh cache if there have been no successful api calls' do
      30.times {|i| FactoryGirl.create(:movie, title: "Movie#{i}")}
      ApiCall.delete_all
      expect(DatabaseRefresher.refresh_cache?).to be true
    end

  end

end