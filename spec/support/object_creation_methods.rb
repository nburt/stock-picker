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

def create_article(attributes = {})
  default_attributes = {
    title: 'Article', description: 'description', date: 'Sat, 28 Mar 2015 21:02:00 GMT',
    link: 'http://us.rd.yahoo.com/finance/news/rss/story/*http://sg.finance.yahoo.com/news/strong-dollar-hurts-hps-earnings-073940904.html'
  }
  article = new_article(default_attributes.merge(attributes))
  article.save
  article
end

def new_article(attributes = {})
  default_attributes = {
    title: 'Article', description: 'description', date: 'Sat, 28 Mar 2015 21:02:00 GMT',
    link: 'http://us.rd.yahoo.com/finance/news/rss/story/*http://sg.finance.yahoo.com/news/strong-dollar-hurts-hps-earnings-073940904.html'
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