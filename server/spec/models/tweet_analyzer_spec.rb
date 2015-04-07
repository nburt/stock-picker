require 'rails_helper'

describe TweetAnalyzer do

  it 'returns a list of keywords and a positivity score for a tweet' do
    VCR.use_cassette('models/tweet_analyzer/text') do
      tweet = create_tweet

      analyzer = TweetAnalyzer.new(tweet)
      analysis = analyzer.analyze!

      expect(analysis.keywords.size).to eq(3)
      expect(analysis.positivity_score > 0).to eq(true)
      expect(analysis.sentiment).to eq({score: 0.501643, type: 'positive'})
    end
  end

  it 'handles when keywords are empty and sentiment is nil' do
    VCR.use_cassette('/models/tweet_analyzer/empty') do
      text = 'AMERIPRISE FINANCIAL INC Financials'
      tweet = Tweet.create!(data: {text: text}, stock_id: 1)

      analyzer = TweetAnalyzer.new(tweet)
      analysis = analyzer.analyze!

      expect(analysis.keywords).to eq([])
      expect(analysis.positivity_score).to eq(nil)
      expect(analysis.sentiment).to eq(nil)
    end
  end

end