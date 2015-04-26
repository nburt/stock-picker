require 'rails_helper'

describe ArticleFetcher::UsaToday do
  include ActiveSupport::Testing::TimeHelpers

  it 'fetches the lastest articles on usa today based on the query' do
    VCR.use_cassette('/models/article_fetcher/usa_today_success') do
      results = ArticleFetcher::UsaToday.fetch('IBM')

      expect(results.size).to eq(1)
      expect(results.first.title).to eq("Key NASA official looks back on Hubble's history")
      expect(results.first.description).to eq("John Campbell as the Hubble program's manager from 1994-2000.")
      expect(results.first.link).to eq('http://www.usatoday.com/story/news/nation/2015/04/24/key-engineer-looks-back-hubbles-history/26337057/')
      expect(results.first.date).to eq('Fri, 24 Apr 2015 08:44:57 GMT')
      expect(results.first.source).to eq('USA Today')
    end
  end

  it 'returns an empty array if there are no articles' do
    VCR.use_cassette('/models/article_fetcher/usa_today_no_articles') do
      results = ArticleFetcher::UsaToday.fetch('IBM')

      expect(results).to eq([])
    end
  end

end