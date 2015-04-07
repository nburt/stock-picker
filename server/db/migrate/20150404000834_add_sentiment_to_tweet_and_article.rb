class AddSentimentToTweetAndArticle < ActiveRecord::Migration
  def change
    add_column :tweets, :sentiment, :json
    add_column :articles, :sentiment, :json
  end
end
