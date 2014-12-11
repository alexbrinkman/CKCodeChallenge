require 'rails_helper'
require 'spec_helper'

RSpec.describe ProjectionEngine do

  context '.last_saturday' do

    after(:each) do
      Timecop.return
    end

    it 'should return the previous Saturdays, starting on a known date' do
      Timecop.freeze(Time.local(2014, 12, 10))
      expect(ProjectionEngine.last_saturday).to eq(Date.new(2014, 12, 6))
    end

  end

  context '.get_projection_dates' do

    after(:each) do
      Timecop.return
    end

    it 'should return the next four Saturdays, starting on a Saturday' do
      Timecop.freeze(Time.local(2014, 11, 22))
      expect(ProjectionEngine.get_projection_dates).to eq([
        Date.new(2014, 11, 22), Date.new(2014, 11, 29),
        Date.new(2014, 12, 6), Date.new(2014, 12, 13)])
    end

    it 'should return the next four Saturdays, starting on a Monday' do
      Timecop.freeze(Time.local(2015, 1, 5))
      expect(ProjectionEngine.get_projection_dates).to eq([
        Date.new(2015, 1, 10), Date.new(2015, 1, 17),
        Date.new(2015, 1, 24), Date.new(2015, 1, 31)])
    end

  end

  context '.project_rankings' do

    it 'should rank the first weekend in the order given' do
      movie_list = ['Movie1', 'Movie2', 'Movie3', 'Movie4', 'Movie5']
      results = ProjectionEngine.project_rankings(movie_list)

      # Just to be sure the order didn't change
      titles = results.map {|item| item[:title]}
      expect(titles).to eq(movie_list)

      week1 = results.map {|item| item[:week1]}
      expect(week1).to eq([1,2,3,4,5])
    end

    it 'should assign a random, but unique, ranking for weeks 2-4' do
      movie_list = ['Movie1', 'Movie2', 'Movie3', 'Movie4', 'Movie5']

      # Since the rankings are random, run through several times to make sure it
      # didn't pass by chance.
      30.times do
        results = ProjectionEngine.project_rankings(movie_list)
        result = results.map {|item| item[:week2]}
        expect(result.uniq.length).to eq(result.length)
      end
    end

  end

  end