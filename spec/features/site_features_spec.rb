require 'rails_helper'

feature 'site walkthrough' do

  before(:all) do
    30.times {|i| FactoryGirl.create(:movie, title: "Movie#{i}")}
  end

  after(:all) do
    Movie.delete_all
  end

  scenario 'user visits root of site' do
    visit '/'
    expect(page).to have_text('Welcome Movie Enthusiast')
    expect(find(:css, 'select').value).to eq('10')
  end

  scenario 'user directly visits last weekends box office results' do
    visit '/past'
    expect(page).to have_text('Box Office Results for the Weekend of:')
    expect(page).to have_css('h2', count: 10)
  end

  #todo: better way to select movies?.
  scenario 'user can change number of movies to show' do
    visit '/'
    select('25', :from => 'show')
    click_button('Search')
    expect(page).to have_css('h2', count: 25)

    visit '/'
    select('5', :from => 'show')
    click_button('Search')
    expect(page).to have_css('h2', count: 5)
  end

  scenario 'user directly visits future box office projections' do
    visit '/future'
    expect(page).to have_text('Box Office Projections for the Weekend starting:')
  end

  #todo: better way to select movies?.
  scenario 'user can view projections of box office results' do
    visit '/'
    click_button('Create')

    # One row for the header, plus one for each movie.
    expect(page).to have_css('tr', count: 6)
  end

end