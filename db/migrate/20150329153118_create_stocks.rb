class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :name, null: false
      t.string :ticker_symbol, null: false
      t.timestamps null: false
    end
  end
end
