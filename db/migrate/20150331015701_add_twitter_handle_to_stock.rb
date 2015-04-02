class AddTwitterHandleToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :twitter_handle, :string
  end
end
