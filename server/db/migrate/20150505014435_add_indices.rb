class AddIndices < ActiveRecord::Migration
  def change
    add_index :reddits, :positivity_score
    add_index :tweets, :positivity_score
    add_index :articles, :positivity_score
  end
end
