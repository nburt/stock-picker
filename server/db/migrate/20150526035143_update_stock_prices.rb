class UpdateStockPrices < ActiveRecord::Migration
  def change
    remove_column :stock_prices, :year_high, :string
    remove_column :stock_prices, :year_low, :string
    remove_column :stock_prices, :bid_realtime, :string
    remove_column :stock_prices, :market_cap, :string
    remove_column :stock_prices, :last_trade_price, :string
    remove_column :stock_prices, :previous_close, :string
    add_column :stock_prices, :close, :string
    add_column :stock_prices, :adj_close, :string
    add_column :stock_prices, :volume, :integer
  end
end
