require 'rails_helper'

describe Analytics::Reddits do

  describe 'added' do

    it 'returns the number of reddits added between two date ranges' do
      start_date = 7.days.ago
      end_date = DateTime.now

      create_reddit(created_at: 1.day.ago)
      create_reddit(created_at: 8.days.ago)
      create_reddit(created_at: 6.days.ago)

      expect(Analytics::Reddits.added(start_date, end_date)).to eq(2)
    end

  end

  describe 'total' do

    it 'returns the total number of reddits added before a date' do
      date = DateTime.now
      create_reddit(created_at: 1.days.ago)
      create_reddit(created_at: 8.days.ago)

      expect(Analytics::Reddits.total(date)).to eq(2)
    end

  end

  describe 'total_scored' do

    it 'returns the total number of scored reddits added before a date' do
      date = DateTime.now
      create_reddit(updated_at: 1.days.ago, data: {text: 'some text'},
                    keywords: ['keyword'], positivity_score: 50)
      create_reddit(updated_at: 8.days.ago, data: {text: 'some other text'},
                    keywords: ['keyword'], positivity_score: 50)
      create_reddit(updated_at: 8.days.ago, data: {text: 'some more text'})

      expect(Analytics::Reddits.total_scored(date)).to eq(2)
    end

  end

  describe 'scored_by_interval' do

    it 'returns the number of reddits scored within a time period' do
      start_date = 7.days.ago
      end_date = DateTime.now
      create_reddit(updated_at: 1.days.ago, data: {text: 'some text'},
                    keywords: ['keyword'], positivity_score: 50)
      create_reddit(updated_at: 2.days.ago, data: {text: 'some more text'})
      create_reddit(updated_at: 8.days.ago, data: {text: 'some other text'},
                    keywords: ['keyword'], positivity_score: 50)

      expect(Analytics::Reddits.scored_by_interval(start_date, end_date)).to eq(1)
    end

  end

end