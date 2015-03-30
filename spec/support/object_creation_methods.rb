def create_stock(attributes = {})
  default_attributes = {name: 'IBM', ticker_symbol: 'IBM'}
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
    link: 'link.com'
  }
  stock = new_article(default_attributes.merge(attributes))
  stock.save
  stock
end

def new_article(attributes = {})
  default_attributes = {
    title: 'Article', description: 'description', date: 'Sat, 28 Mar 2015 21:02:00 GMT',
    link: 'link.com'
  }
  Article.new(default_attributes.merge(attributes))
end