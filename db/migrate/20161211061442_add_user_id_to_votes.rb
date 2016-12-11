class AddUserIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :user_id, :integer, presence: true
    add_index :votes, [:user_id, :voteable_id, :voteable_type], unique: true
  end
end
