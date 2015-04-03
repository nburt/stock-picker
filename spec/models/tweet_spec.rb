require 'rails_helper'

describe Tweet do

  describe 'analyze!' do

    it 'analyzes a tweets text and stores the keywords and positivity score' do
      VCR.use_cassette('/models/tweet/analyze') do
        tweet = create_tweet

        tweet.analyze!

        expect(tweet.positivity_score > 0).to eq(true)
        expect(tweet.keywords.any?).to eq(true)
      end
    end

    it 'does not run an analysis if the article already has keywords or a positivity score' do
      tweet = create_tweet(keywords: ['keyword'], positivity_score: 50)
      expect(tweet.analyze!).to eq(false)
    end

  end

  describe 'scored' do

    it 'returns tweets with a positivity score' do
      tweet = create_tweet(keywords: ['keyword'], positivity_score: 50)
      create_tweet(stock_id: 2)

      expect(Tweet.scored).to eq([tweet])
    end

  end

  describe 'unscored' do
    it 'returns tweets without a positivity score' do
      tweet = create_tweet
      create_tweet(stock_id: 2, keywords: ['keyword'], positivity_score: 50)

      expect(Tweet.unscored).to eq([tweet])
    end
  end

end