class AddIndicesToMedia < ActiveRecord::Migration
  def change
    add_index :reddits, :title
    add_index :reddits, :link
    add_index :reddits, :date
    add_index :reddits, :subreddit_id

    add_index :articles, :title
    add_index :articles, :link
    add_index :articles, :source
  end
end
