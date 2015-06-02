require 'rails_helper'

describe BingSearcher do

  it 'searches bing for new articles' do
    VCR.use_cassette('/models/bing_search_success') do
      results = BingSearcher.search_all('IBM')

      expect(results.size).to eq(120)
      expect(results.first.title).to eq('Apple has sold 7 million watches, concludes tech analyst')
    end
  end

end