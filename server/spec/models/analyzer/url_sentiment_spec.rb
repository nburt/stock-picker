require 'rails_helper'

describe Analyzer::Sentiment::UrlSentiment do

  it 'runs sentiment analysis on text' do
    VCR.use_cassette('/models/analyzer/url_sentiment/success') do
      url = 'http://us.rd.yahoo.com/finance/news/rss/story/*http://sg.finance.' +
        'yahoo.com/news/strong-dollar-hurts-hps-earnings-073940904.html'

      analyzer = Analyzer::Sentiment::UrlSentiment.new(url)
      sentiment = analyzer.analyze!

      expected = {
        score: -0.242855,
        type: 'negative'
      }

      expect(sentiment).to eq(expected)
    end
  end

  it 'returns nil unless a url is present' do
    text = ''

    analyzer = Analyzer::Sentiment::UrlSentiment.new(text)
    sentiment = analyzer.analyze!

    expect(sentiment).to eq(nil)
  end

  it 'returns nil if the url is invalid' do
    VCR.use_cassette('/models/analyzer/url_sentiment/invalid') do
      url = 'text'

      analyzer = Analyzer::Sentiment::UrlSentiment.new(url)
      sentiment = analyzer.analyze!

      expect(sentiment).to eq(nil)
    end
  end

end