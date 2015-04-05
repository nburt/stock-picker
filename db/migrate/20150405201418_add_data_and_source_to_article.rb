class AddDataAndSourceToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :data, :json
    add_column :articles, :source, :string
  end
end
