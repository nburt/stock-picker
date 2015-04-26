require 'rails_helper'

describe ArticleFetcher::Nasdaq do

  it 'fetches articles from the street rss feed related to a stock' do
    VCR.use_cassette('/models/article_fetcher/nasdaq_success') do
      results = ArticleFetcher::Nasdaq.fetch('IBM')

      expect(results.size).to eq(30)
      expect(results.first.title).to eq('Amazon Surprises Investors as AWS Hits $5B in 2014 Sales - Analyst Blog')
      expect(results.first.link).to eq('http://articlefeeds.nasdaq.com/~r/nasdaq/symbols/~3/675iKGsUxyU/amazon-surprises-investors-as-aws-hits-5b-in-2014-sales-analyst-blog-cm469243')
      expect(results.first.date).to eq('Fri, 24 Apr 2015 23:23:34 Z')
      expect(results.first.source).to eq('Nasdaq')
    end
  end

end