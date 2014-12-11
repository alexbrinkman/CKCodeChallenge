namespace :movies do
  desc 'Refresh the movies database from the Rotten Tomatoes server'
  task refresh: :environment do
    DatabaseRefresher.refresh(true, :rake)
  end

  desc 'Completely clear the database of movies and api call records'
  task destroy_all: :environment do
    Movie.destroy_all
    ApiCall.destroy_all
  end
end
