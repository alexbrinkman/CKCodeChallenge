require 'rails_helper'
require 'spec_helper'

RSpec.describe ProjectionEngine do

  context '.get_projection_dates' do

    after(:each) do
      Timecop.return
    end

    it 'should return the next four Saturdays, starting on a Saturday' do
      Timecop.freeze(Time.local(2014, 11, 22))
      expect(ProjectionEngine.get_projection_dates).to eq(['11/22', '11/29', '12/6', '12/13'])
    end

    it 'should return the next four Saturdays, starting on a Monday' do
      Timecop.freeze(Time.local(2015, 1, 5))
      expect(ProjectionEngine.get_projection_dates).to eq(['1/10', '1/17', '1/24', '1/31'])
    end

  end

  context '.get_movies' do

    it 'should rank the first weekend in the order given' do
      movie_list = ['Movie1', 'Movie2', 'Movie3', 'Movie4', 'Movie5']
      results = ProjectionEngine.get_movies(movie_list)

      # Just to be sure the order didn't change
      titles = results.map {|item| item[:title]}
      expect(titles).to eq(movie_list)

      week1 = results.map {|item| item[:week1]}
      expect(week1).to eq([1,2,3,4,5])
    end

  end

end