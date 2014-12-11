require 'rails_helper'

feature 'site walkthrough' do

  before(:all) do
    30.times {|i| FactoryGirl.create(:movie, title: "Movie#{i}")}
    FactoryGirl.create(:api_call, created_at: Time.zone.now)
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
    expect(page).to have_css('.movie-view', count: 10)
    expect(page).to have_css('img.movie-thumb', count: 10)

    # Test style guidelines with links. 1 for each icon, the two links, header link.
    expect(page).to have_css('a[href*=rottentomatoes]', count: 41)
  end

  scenario 'site should not allow a show value larger than 25' do
    visit '/past?show=?200'
    expect(page).to have_css('.movie-view', count: 10)
  end

  scenario 'site should not allow an negative show value' do
    visit '/past?show=?0'
    expect(page).to have_css('.movie-view', count: 10)
  end

  scenario 'user can change number of movies to show' do
    visit '/'
    select('25', from: 'show')
    click_button('Search')
    expect(page).to have_css('.movie-view', count: 25)

    visit '/'
    select('5', from: 'show')
    click_button('Search')
    expect(page).to have_css('.movie-view', count: 5)
  end

  scenario 'user directly visits future box office projections' do
    visit '/future'
    expect(page).to have_text('Box Office Projections for the Weekend starting:')
  end

  scenario 'user can view projections of box office results' do
    visit '/'
    click_button('Project')

    # One row for the header, plus one for each movie.
    expect(page).to have_css('tr', count: 6)
  end

end