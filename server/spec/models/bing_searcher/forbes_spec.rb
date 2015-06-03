require 'rails_helper'

describe BingSearcher::Forbes do

  it 'searches for the top 200 market watch articles on bing' do
    VCR.use_cassette('/models/bing_searcher/forbes_success') do
      results = BingSearcher::Forbes.search('IBM')

      expect(results.size).to eq(48)
      expect(results.first.title).to eq('How Two Companies Are Exploiting Hybrid Clouds')
      expect(results.first.date).to eq('2015-06-01T10:01:59Z')
      expect(results.first.description).to eq('Richard A. Patterson is General Manager of Infrastructure Services at IBM. There is a new way to work, and it’s made with IBM. Learn more at ibm.com/madewithibm or join the conversation at #MadeWithIBM')
      expect(results.first.source).to eq('Forbes')
      expect(results.first.link).to eq('http://www.forbes.com/sites/ibm/2015/06/01/how-two-companies-are-exploiting-hybrid-clouds/')
    end
  end

end