require 'rails_helper'

describe Analyzer::Sentiment::TextSentiment do

  it 'runs sentiment analysis on text' do
    VCR.use_cassette('/models/analyzer/sentiment/sentiment') do
      text = "Strong dollar hurts HP's earnings forecast, shares plummet"

      analyzer = Analyzer::Sentiment::TextSentiment.new(text)
      sentiment = analyzer.analyze!

      expected = {
        score: -0.826981,
        type: 'negative'
      }

      expect(sentiment).to eq(expected)
    end
  end

  it 'returns nil unless text is present' do
    text = ''

    analyzer = Analyzer::Sentiment::TextSentiment.new(text)
    sentiment = analyzer.analyze!

    expect(sentiment).to eq(nil)
  end

  it 'handles errors gracefully' do
    VCR.use_cassette('/models/analyzer/sentiment/error') do
      text = 'AMERIPRISE FINANCIAL INC Financials'

      analyzer = Analyzer::Sentiment::TextSentiment.new(text)
      sentiment = analyzer.analyze!

      expect(sentiment).to eq(nil)
    end
  end

end
