require 'rails_helper'

describe ArticleFetcher::SeekingAlpha do

  it 'fetches articles for a stock given the stock name' do
    VCR.use_cassette('/models/article_fetcher/seeking_alpha_success') do
      results = ArticleFetcher::SeekingAlpha.fetch('IBM')

      expect(results.size).to eq(30)
      expect(results.first.title).to eq("IBM's Software Franchise Widens Its Moat")
      expect(results.first.link).to eq('http://seekingalpha.com/article/3100736-ibms-software-franchise-widens-its-moat?source=feed_symbol_IBM')
      expect(results.first.date).to eq('Fri, 24 Apr 2015 14:46:03 -0400')
      expect(results.first.source).to eq('Seeking Alpha')
    end
  end

end