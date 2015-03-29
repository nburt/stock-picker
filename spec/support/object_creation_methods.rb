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