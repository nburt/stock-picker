class AddDateToStockPrice < ActiveRecord::Migration
  def change
    add_column :stock_prices, :date, :datetime
    add_index :stock_prices, :date
  end
end
