class ChangeArticlesSentimentToPositivityScore < ActiveRecord::Migration
  def change
    remove_column  :articles, :sentiment
    add_column :articles, :positivity_score, :float
  end
end
