namespace :fetch do
  desc "Fetch Stock Prices"
  task stock_prices: :environment do
    stocks = Stock.all
    count = stocks.size
    stocks.each_with_index do |stock, index|
      p "#{index} out of #{count}"
      stock.fetch_and_save_current_price
    end
  end

  desc "Fetch Articles"
  task articles: :environment do
    stocks = Stock.all
    count = stocks.size
    stocks.each_with_index do |stock, index|
      p "#{index} out of #{count}"
      stock.fetch_and_save_new_articles
    end
  end

end