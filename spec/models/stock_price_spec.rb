require 'rails_helper'

describe StockPrice do

  describe 'validations' do

    let(:stock_price) { StockPrice.new(stock_id: 1) }

    it 'must have a stock_id' do
      expect(stock_price).to be_valid
      stock_price.stock_id = nil
      expect(stock_price).to_not be_valid
    end

    it 'cannot be from the same day and stock' do
      expect(stock_price).to be_valid
      StockPrice.create!(stock_id: 1)
      expect(stock_price).to_not be_valid
    end

    it 'can be created if it is from a different day' do
      expect(stock_price).to be_valid
      StockPrice.create!(stock_id: 1, created_at: 1.day.ago)
      expect(stock_price).to be_valid
    end

  end

end