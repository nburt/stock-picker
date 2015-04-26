require 'rails_helper'

describe Analytics::Tweets do

  describe 'added' do

    it 'returns the number of tweets added between two date ranges' do
      start_date = 7.days.ago
      end_date = DateTime.now

      create_tweet(created_at: 1.day.ago)
      create_tweet(created_at: 8.days.ago, data: {text: 'some text'})
      create_tweet(created_at: 6.days.ago, data: {text: 'some other text'})

      expect(Analytics::Tweets.added(start_date, end_date)).to eq(2)
    end

  end

end