require 'rails_helper'

feature 'site walkthrough' do

  scenario 'user visits root of site' do
    visit '/'
    expect(page).to have_text('Welcome Movie Enthusiast')
    expect(find(:css, 'select').value).to eq('10')
  end

  scenario 'user visits last weekends box office results' do
    visit '/past'
    expect(page).to have_text('Box Office Results for the Weekend of:')
  end

  scenario 'user visits future box office projections' do
    visit '/future'
    expect(page).to have_text('Box Office Projections for the Weekend starting:')
  end

end