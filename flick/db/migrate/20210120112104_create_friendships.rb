class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :requester, null: false, foreign_key: {to_table: :users}
      t.references :addressee, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
