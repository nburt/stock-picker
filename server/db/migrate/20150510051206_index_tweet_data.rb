class IndexTweetData < ActiveRecord::Migration
  def change
    add_index :tweets, :data, using: :gin
  end
end
