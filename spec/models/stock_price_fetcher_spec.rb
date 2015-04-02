require 'rails_helper'

describe StockPriceFetcher do

  it 'fetches the latest price information for a stock' do
    VCR.use_cassette('models/stock_price_fetcher/price_information') do
      results = StockPriceFetcher.fetch('IBM')
      expect(results.open).to eq('N/A')
      expect(results.previous_close).to eq('N/A')
      expect(results.year_high).to eq('N/A')
      expect(results.year_low).to eq('N/A')
      expect(results.days_high).to eq('N/A')
      expect(results.days_low).to eq('N/A')
      expect(results.bid_realtime).to eq('N/A')
      expect(results.market_cap).to eq('158.54B')
      expect(results.last_trade_price).to eq('160.40')
    end
  end

end