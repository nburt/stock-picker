require 'rails_helper'

describe 'analytics api' do

  describe 'tweets_added' do

    it 'returns the number of tweets added each period over the past month' do
      end_date = DateTime.now
      Timecop.freeze(end_date) do
        create_tweet
        create_tweet(created_at: 8.days.ago, data: {text: 'some text'})
        create_tweet(created_at: 15.days.ago, data: {text: 'some other text'})
        create_tweet(created_at: 22.days.ago, data: {text: 'some other text'})
        create_tweet(created_at: 29.days.ago, data: {text: 'some other text'})

        expected = {
          period_1: {
            start_date: 28.days.ago,
            end_date: 21.days.ago,
            tweets_added: 1
          },
          period_2: {
            start_date: 21.days.ago,
            end_date: 14.days.ago,
            tweets_added: 1
          },
          period_3: {
            start_date: 14.days.ago,
            end_date: 7.days.ago,
            tweets_added: 1
          },
          period_4: {
            start_date: 7.days.ago,
            end_date: end_date,
            tweets_added: 1
          }
        }.to_json

        get '/api/v1/analytics/tweets_added'

        expect(response.status).to eq(200)
        expect(response.body).to eq(expected)
      end
    end

  end

  describe 'tweets_added_by_stock'

end