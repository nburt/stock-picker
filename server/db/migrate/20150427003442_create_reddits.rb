class CreateReddits < ActiveRecord::Migration
  def change
    create_table :reddits do |t|
      t.integer :stock_id
      t.index :stock_id
      t.string :title
      t.string :link
      t.datetime :date
      t.json :data
      t.string :subreddit_id
      t.json :keywords
      t.float :positivity_score
      t.json :sentiment

      t.timestamps null: false
    end
  end
end
