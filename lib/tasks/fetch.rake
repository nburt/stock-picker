namespace :fetch do
  desc "Fetch Stock Prices"
  task stock_prices: :environment do
    return false if ["Saturday", "Sunday"].include?(DateTime.now.strftime("%A"))
    stocks = Stock.all
    count = stocks.size
    stocks.each_with_index do |stock, index|
      p "#{index + 1} out of #{count}"
      stock.fetch_and_save_current_price
    end
  end

  desc "Fetch Articles and Tweets"
  task articles_tweets: :environment do
    stocks = Stock.all
    count = stocks.size
    stocks.each_with_index do |stock, index|
      p "#{index + 1} out of #{count}"
      stock.fetch_and_save_new_articles
      stock.fetch_and_save_new_tweets
    end
  end

end