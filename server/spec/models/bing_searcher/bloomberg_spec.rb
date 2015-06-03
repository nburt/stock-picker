require 'rails_helper'

describe BingSearcher::Bloomberg do

  it 'searches for the top 200 market watch articles on bing' do
    VCR.use_cassette('/models/bing_searcher/bloomberg_success') do
      results = BingSearcher::Bloomberg.search('IBM')

      expect(results.size).to eq(4)
      result = results.first
      expect(result.title).to eq('Foundation Medicine’s Tumor Network Helps Doctors Find a Match')
      expect(result.date).to eq('2015-05-27T23:58:16Z')
      expect(result.description).to eq('Even traditional tech companies like IBM Corp. are creating cloud-computing platforms to allow drug companies to store and analyze patient data. In Foundation Medicine’s database, 39 percent had a matching profile within the same institution, according ...')
      expect(result.source).to eq('Bloomberg')
      expect(result.link).to eq('http://www.bloomberg.com/news/articles/2015-05-28/foundation-medicine-s-tumor-network-helps-doctors-find-a-match')
    end
  end

end