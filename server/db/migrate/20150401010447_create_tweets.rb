class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :stock_id
      t.index :stock_id
      t.json :data
      t.json :keywords
      t.float :positivity_score
      t.timestamps null: false
    end
  end
end
