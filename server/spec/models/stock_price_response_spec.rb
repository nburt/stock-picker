require 'rails_helper'

describe StockPriceResponse do

  it 'takes a csv of the stock price and formats it' do
    csv = "N/A,N/A,N/A,N/A,N/A,N/A,N/A,158.54B,160.40"
    response = StockPriceResponse.new(csv)

    expect(response.open).to eq('N/A')
    expect(response.previous_close).to eq('N/A')
    expect(response.year_high).to eq('N/A')
    expect(response.year_low).to eq('N/A')
    expect(response.days_high).to eq('N/A')
    expect(response.days_low).to eq('N/A')
    expect(response.bid_realtime).to eq('N/A')
    expect(response.market_cap).to eq('158.54B')
    expect(response.last_trade_price).to eq('160.40')
  end

end