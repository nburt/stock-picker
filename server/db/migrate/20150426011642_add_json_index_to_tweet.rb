class AddJsonIndexToTweet < ActiveRecord::Migration
  def up
    Tweet.connection.execute("CREATE INDEX ON tweets((data->>'id_str'))")
  end

  def down
    Tweet.connection.execute("DROP INDEX ON tweets((data->>'id_str'))")
  end
end
