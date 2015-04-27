require 'rails'
job_type :rake, 'cd :path && RAILS_ENV=:environment bundle exec rake :task :output'
set :output, '/var/log/whenever/whenever.log'
Time.zone = 'US/Eastern'

every '45 * * * *', roles: [:app] do
  rake 'fetch:articles'
end

every '0 * * * *', roles: [:app] do
  rake 'fetch:tweets'
end

every '30 * * * *', roles: [:app] do
  rake 'fetch:tweets_2'
end

every '20,40 * * * *', roles: [:app] do
  rake 'fetch:reddits'
end

every 1.day, at: Time.zone.parse('6:45 pm').utc, roles: [:app] do
  rake 'fetch:stock_prices'
end

every 1.day, at: Time.zone.parse('11:10 pm').utc, roles: [:app] do
  rake 'score:articles'
end

every 1.day, at: Time.zone.parse('5:35 pm').utc, roles: [:app] do
  rake 'score:tweets'
end