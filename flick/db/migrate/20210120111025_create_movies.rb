class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :date
      t.string :description
      t.string :genre
      t.string :run_time

      t.timestamps
    end
  end
end
