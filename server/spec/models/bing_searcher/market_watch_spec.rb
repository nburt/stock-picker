require 'rails_helper'

describe BingSearcher::MarketWatch do

  it 'searches for the top 200 market watch articles on bing' do
    VCR.use_cassette('/models/bing_searcher/market_watch_success') do
      results = BingSearcher::MarketWatch.search('IBM')

      expect(results.size).to eq(38)
      expect(results.first.title).to eq('IBM Closes Acquisition of Phytel')
      expect(results.first.date).to eq('2015-05-04T17:30:22Z')
      expect(results.first.description).to eq('ARMONK, N.Y. and DALLAS, May 4, 2015 /PRNewswire/ -- IBM (NYSE: IBM) today announced it has completed the acquisition of Phytel, a leading provider of integrated population health management software based in Dallas, Texas. Financial terms of the deal were ...')
      expect(results.first.source).to eq('Market Watch')
      expect(results.first.link).to eq('http://www.marketwatch.com/story/ibm-closes-acquisition-of-phytel-2015-05-04')
    end
  end

end