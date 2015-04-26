require 'rails_helper'

describe ArticleFetcher do
  include ActiveSupport::Testing::TimeHelpers

  it 'fetches new articles' do
    VCR.use_cassette('models/article_fetcher/fetch_new_articles') do
      date = DateTime.parse('Sat, 04 Apr 2015 19:57:00 UTC +00:00 ')
      travel_to(date) do
        results = ArticleFetcher.fetch_all('IBM')

        expect(results.size).to eq(92)
        expect(results.last.title).to eq('Stocks Turn Mixed After Moving Higher At The Open - U.S. Commentary')
      end
    end
  end

end