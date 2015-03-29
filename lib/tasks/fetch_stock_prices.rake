namespace :fetch do
  desc "Fetch Stock Prices"
  task stock_prices: :environment do
    stocks = Stock.all
    stocks.each do |stock|
      stock.fetch_and_save_current_price
    end
  end

end