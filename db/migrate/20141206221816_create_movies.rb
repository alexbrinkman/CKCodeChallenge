class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :poster_thumb_url
      t.integer :year
      t.string :mpaa_rating
      t.string :critics_rating
      t.integer :critics_score
      t.string :audience_rating
      t.integer :audience_score
      t.string :movie_details
      t.string :movie_reviews
      t.timestamps
    end
  end
end
