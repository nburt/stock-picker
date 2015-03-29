class Stock < ActiveRecord::Base
  validates_presence_of :name, :ticker_symbol
  validates_uniqueness_of :name, :ticker_symbol
end
