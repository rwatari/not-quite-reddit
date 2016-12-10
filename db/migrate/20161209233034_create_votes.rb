class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value, null: false
      t.references :voteable, polymorphic: true, index: true, null: false

      t.timestamps null: false
    end
  end
end
