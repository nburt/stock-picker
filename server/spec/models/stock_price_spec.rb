require 'rails_helper'

describe StockPrice do

  describe 'validations' do

    let(:stock_price) { StockPrice.new(stock_id: 1) }

    it 'must have a stock_id' do
      expect(stock_price).to be_valid
      stock_price.stock_id = nil
      expect(stock_price).to_not be_valid
    end

  end

end