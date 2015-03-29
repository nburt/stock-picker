require 'rails_helper'

describe Stock do

  before(:each) do
    @stock = new_stock
  end

  describe 'validations' do

    it 'must have a name' do
      expect(@stock).to be_valid
      @stock.name = nil
      expect(@stock).to_not be_valid
    end

    it 'must have a ticker symbol' do
      expect(@stock).to be_valid
      @stock.ticker_symbol = nil
      expect(@stock).to_not be_valid
    end

    it 'must have a unique name and ticker symbol' do
      expect(@stock).to be_valid
      create_stock
      expect(@stock).to_not be_valid
      @stock.name = 'American Express'
      expect(@stock).to_not be_valid
      @stock.ticker_symbol = 'AXP'
      expect(@stock).to be_valid
    end

  end

  describe 'fetch_and_save_current_price' do

    it 'returns false if it has already been fetched within the last day' do
      stock = create_stock
      StockPrice.create!(stock_id: stock.id)

      expect(stock.fetch_and_save_current_price).to eq(false)
      expect(StockPrice.count).to eq(1)
    end

    it 'fetches the stocks quote and saves it if it does not have it' do
      VCR.use_cassette('models/stock_price/fetch_and_save') do
        stock = create_stock
        stock.fetch_and_save_current_price

        stock_price = stock.stock_prices.first
        expect(stock_price.open).to eq('N/A')
        expect(stock_price.previous_close).to eq('N/A')
        expect(stock_price.year_high).to eq('N/A')
        expect(stock_price.year_low).to eq('N/A')
        expect(stock_price.days_high).to eq('N/A')
        expect(stock_price.days_low).to eq('N/A')
        expect(stock_price.bid_realtime).to eq('N/A')
        expect(stock_price.market_cap).to eq('158.54B')
        expect(stock_price.last_trade_price).to eq('160.40')
      end
    end

  end

end