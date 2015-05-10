class UpdateTweetJsonToJsonb < ActiveRecord::Migration
  def up
    change_column :tweets, :data, 'jsonb USING CAST(data AS jsonb)'
  end

  def down
    change_column :tweets, :data, 'json USING CAST(data AS json)'
  end
end
