def create_stock(attributes = {})
  default_attributes = {name: 'IBM', ticker_symbol: 'IBM', twitter_handle: '@IBM'}
  stock = new_stock(default_attributes.merge(attributes))
  stock.save
  stock
end

def new_stock(attributes = {})
  default_attributes = {name: 'IBM', ticker_symbol: 'IBM'}
  Stock.new(default_attributes.merge(attributes))
end

def create_stock_price(attributes = {})
  default_attributes = {
    stock_id: 1,
    open: '125.71',
    days_high: '126.5',
    days_low: '124.41',
    close: '124.62',
    volume: 1232445,
    adj_close: '124.62'
  }
  stock = new_stock_price(default_attributes.merge(attributes))
  stock.save
  stock
end

def new_stock_price(attributes = {})
  default_attributes = {
    stock_id: 1,
    open: '125.71',
    days_high: '126.5',
    days_low: '124.41',
    close: '124.62',
    volume: 1232445,
    adj_close: '124.62'
  }
  StockPrice.new(default_attributes.merge(attributes))
end

def create_article(attributes = {})
  default_attributes = {
    title: 'Article', description: 'description', date: 'Sat, 28 Mar 2015 21:02:00 GMT',
    link: 'http://us.rd.yahoo.com/finance/news/rss/story/*http://sg.finance.yahoo.com/news/strong-dollar-hurts-hps-earnings-073940904.html',
    stock_id: 1
  }
  article = new_article(default_attributes.merge(attributes))
  article.save
  article
end

def new_article(attributes = {})
  default_attributes = {
    title: 'Article', description: 'description', date: 'Sat, 28 Mar 2015 21:02:00 GMT',
    link: 'http://us.rd.yahoo.com/finance/news/rss/story/*http://sg.finance.yahoo.com/news/strong-dollar-hurts-hps-earnings-073940904.html',
    stock_id: 1
  }
  Article.new(default_attributes.merge(attributes))
end

def create_tweet(attributes = {})
  text = '$IBM to invest $3 billion in sensor data unit: http://t.co/bMtwsjiTFf'
  default_attributes = {
    data: {text: text},
    stock_id: 1
  }

  tweet = new_tweet(default_attributes.merge(attributes))
  tweet.save
  tweet
end

def new_tweet(attributes = {})
  text = '$IBM to invest $3 billion in sensor data unit: http://t.co/bMtwsjiTFf'
  default_attributes = {
    data: {text: text},
    stock_id: 1
  }
  Tweet.new(default_attributes.merge(attributes))
end

def create_reddit(attributes = {})
  reddit = new_reddit(attributes)
  reddit.save
  reddit
end

def new_reddit(attributes = {})
  default_attributes = {
    title: "Assistance evaluating IBM's Watson Analytics?",
    link: 'http://www.reddit.com/r/datascience/comments/33ylaf/assistance_evaluating_ibms_watson_analytics/',
    date: 'Sun, 26 Apr 2015 23:35:49 -0600',
    subreddit_id: 't5_2sptq',
    stock_id: 1
  }
  Reddit.new(default_attributes.merge(attributes))
end