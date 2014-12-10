namespace :movies do
  desc 'Refresh the movies database from the Rotten Tomatoes server'
  task refresh: :environment do
    DatabaseRefresher.refresh true
  end
end
