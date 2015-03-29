class StockPrice < ActiveRecord::Base
  belongs_to :stock

  validates_presence_of :stock_id
  validate :one_stock_price_per_day

  private

  def one_stock_price_per_day
    if StockPrice.where(stock_id: stock_id).where("created_at < ? AND created_at > ?", DateTime.now, 1.days.ago).any?
      errors.add(:base, "Can only have one stock price per stock per day.")
    end
  end
end
