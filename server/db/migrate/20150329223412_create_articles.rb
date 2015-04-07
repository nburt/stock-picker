class CreateArticles < ActiveRecord::Migration
  def change
    add_index :stock_prices, :stock_id

    create_table :articles do |t|
      t.integer :stock_id
      t.index :stock_id
      t.string :title
      t.text :description
      t.string :link
      t.datetime :date
      t.json :keywords
      t.string :sentiment

      t.timestamps null: false
    end
  end
end
