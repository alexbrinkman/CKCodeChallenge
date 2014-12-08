class CreateApiCalls < ActiveRecord::Migration
  def change
    create_table :api_calls do |t|
      t.string :source
      t.string :status

      t.timestamps
    end
  end
end
