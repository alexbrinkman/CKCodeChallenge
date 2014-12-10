class AddBoxOfficeRankingToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :box_office_ranking, :integer
  end
end
