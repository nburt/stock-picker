class StockPrice < ActiveRecord::Base
  belongs_to :stock

  validates_presence_of :stock_id
end
