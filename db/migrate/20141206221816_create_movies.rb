class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :poster_url
      t.integer :year
      t.string :mpaa_rating
      t.string :critics_rating
      t.integer :critics_score
      t.string :audience_rating
      t.integer :audience_score
      t.string :movie_details_url
      t.string :movie_reviews_url
      t.timestamps
    end
  end
end
