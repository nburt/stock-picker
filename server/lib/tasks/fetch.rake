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
  task articles: :environment do
    stocks = Stock.all
    count = stocks.size
    stocks.each_with_index do |stock, index|
      p "#{index + 1} out of #{count}"
      stock.fetch_and_save_new_articles
    end
  end

  desc "Fetch Tweets"
  task tweets: :environment do
    stocks = Stock.all
    count = stocks.size
    stocks.each_with_index do |stock, index|
      p "#{index + 1} out of #{count}"
      stock.fetch_and_save_new_tweets
    end
  end

  desc "Fetch Tweets 2"
  task tweets_2: :environment do
    stocks = Stock.all
    count = stocks.size
    stocks.each_with_index do |stock, index|
      p "#{index + 1} out of #{count}"
      stock.fetch_and_save_new_tweets(stock.twitter_handle)
    end
  end

  desc "Fetch Reddits"
  task reddits: :environment do
    stocks = Stock.all
    count = stocks.size
    stocks.each_with_index do |stock, index|
      p "#{index + 1} out of #{count}"
      stock.fetch_and_save_reddits(stock.name)
    end
  end
end