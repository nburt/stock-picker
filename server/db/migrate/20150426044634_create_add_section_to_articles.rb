class CreateAddSectionToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :section, :json
  end
end
