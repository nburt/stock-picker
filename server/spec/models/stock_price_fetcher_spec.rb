require 'rails_helper'

describe StockPriceFetcher do

  it 'fetches price information for a stock since the date passed in' do
    VCR.use_cassette('models/stock_price_fetcher/price_information') do
      date = DateTime.parse('Sat, 04 Apr 2015 19:57:00 UTC +00:00')
      Timecop.freeze(date) do
        results = StockPriceFetcher.fetch!('IBM', 20.days.ago)
        expect(results.size).to eq(14)

        result = results.first
        expect(result.date).to eq('2015-04-02')
        expect(result.open).to eq('159.52')
        expect(result.days_high).to eq('162.53999')
        expect(result.days_low).to eq('158.89')
        expect(result.close).to eq('160.45')
        expect(result.volume).to eq('4671600')
        expect(result.adj_close).to eq('159.24486')
      end
    end
  end

end