module Api
  module V1
    module Analytics
      class TweetsController < ApplicationController

        def added
          date_1 = 28.days.ago
          date_2 = 21.days.ago
          date_3 = 14.days.ago
          date_4 = 7.days.ago
          end_date = DateTime.now

          added_period_1 = ::Analytics::Tweets.added(date_1, date_2)
          added_period_2 = ::Analytics::Tweets.added(date_2, date_3)
          added_period_3 = ::Analytics::Tweets.added(date_3, date_4)
          added_period_4 = ::Analytics::Tweets.added(date_4, end_date)

          json = {
            period_1: period_hash(date_1, date_2, added_period_1),
            period_2: period_hash(date_2, date_3, added_period_2),
            period_3: period_hash(date_3, date_4, added_period_3),
            period_4: period_hash(date_4, end_date, added_period_4),
          }

          render status: 200, json: json
        end

        def total
          date_1 = 28.days.ago
          date_2 = 21.days.ago
          date_3 = 14.days.ago
          date_4 = 7.days.ago
          end_date = DateTime.now

          added_period_1 = ::Analytics::Tweets.total(date_2)
          added_period_2 = ::Analytics::Tweets.total(date_3)
          added_period_3 = ::Analytics::Tweets.total(date_4)
          added_period_4 = ::Analytics::Tweets.total(end_date)

          json = {
            period_1: period_hash(date_1, date_2, added_period_1),
            period_2: period_hash(date_2, date_3, added_period_2),
            period_3: period_hash(date_3, date_4, added_period_3),
            period_4: period_hash(date_4, end_date, added_period_4),
          }

          render status: 200, json: json
        end

        def total_scored
          date_1 = 28.days.ago
          date_2 = 21.days.ago
          date_3 = 14.days.ago
          date_4 = 7.days.ago
          end_date = DateTime.now

          added_period_1 = ::Analytics::Tweets.total_scored(date_2)
          added_period_2 = ::Analytics::Tweets.total_scored(date_3)
          added_period_3 = ::Analytics::Tweets.total_scored(date_4)
          added_period_4 = ::Analytics::Tweets.total_scored(end_date)

          json = {
            period_1: period_hash(date_1, date_2, added_period_1),
            period_2: period_hash(date_2, date_3, added_period_2),
            period_3: period_hash(date_3, date_4, added_period_3),
            period_4: period_hash(date_4, end_date, added_period_4),
          }

          render status: 200, json: json
        end

        private

        def period_hash(start_date, end_date, tweets)
          {
            start_date: start_date,
            end_date: end_date,
            tweets: tweets
          }
        end

      end
    end
  end
end