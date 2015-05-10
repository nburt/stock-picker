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

  describe 'total' do

    it 'returns the total number of tweets added before a date' do
      date = DateTime.now
      create_tweet(created_at: 1.days.ago, data: {text: 'some text'})
      create_tweet(created_at: 8.days.ago, data: {text: 'some other text'})

      expect(Analytics::Tweets.total(date)).to eq(2)
    end

  end

  describe 'total_scored' do

    it 'returns the total number of scored tweets added before a date' do
      date = DateTime.now
      create_tweet(updated_at: 1.days.ago, data: {text: 'some text'},
                   keywords: ['keyword'], positivity_score: 50)
      create_tweet(updated_at: 8.days.ago, data: {text: 'some other text'},
                   keywords: ['keyword'], positivity_score: 50)
      create_tweet(updated_at: 8.days.ago, data: {text: 'some more text'})

      expect(Analytics::Tweets.total_scored(date)).to eq(2)
    end

  end

  describe 'scored_by_interval' do

    it 'returns the number of tweets scored within a time period' do
      start_date = 7.days.ago
      end_date = DateTime.now
      create_tweet(updated_at: 1.days.ago, data: {text: 'some text'},
                   keywords: ['keyword'], positivity_score: 50)
      create_tweet(updated_at: 3.days.ago, data: {text: 'some more text'})
      create_tweet(updated_at: 8.days.ago, data: {text: 'some other text'},
                   keywords: ['keyword'], positivity_score: 50)

      expect(Analytics::Tweets.scored_by_interval(start_date, end_date)).to eq(1)
    end

  end

end