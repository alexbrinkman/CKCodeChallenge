# require 'spec_helper'

# feature 'populate movie database' do

#   ROTTEN_TOMATOES_URI = 'http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=bbbv6grs52qsvyerxqstj7zr&limit=25'

#   before(:each) do
#     stub_request(:get, ROTTEN_TOMATOES_URI)
#       .to_return(body: File.new('./spec/support/sample_response.json'), status: 200)
#   end

#   it 'should clear and populate the database with 25 movies' do
#     Movie.delete_all # Make sure we are at 0 to know that the count changed.
#     expect{ DatabaseRefresher.refresh }.to change{ Movie.count }.from(0).to(25)
#   end

#   it 'should not refresh the database if it has been less than the cached amount of time' do
#     expect{ DatabaseRefresher.refresh }.not_to change{ Movie.count }
#   end
# end