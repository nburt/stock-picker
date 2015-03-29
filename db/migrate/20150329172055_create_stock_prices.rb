class CreateStockPrices < ActiveRecord::Migration
  def change
    create_table :stock_prices do |t|
      t.integer :stock_id
      t.string :open
      t.string :previous_close
      t.string :year_high
      t.string :year_low
      t.string :days_high
      t.string :days_low
      t.string :bid_realtime
      t.string :market_cap
      t.string :last_trade_price
      t.timestamps null: false
    end
  end
end
