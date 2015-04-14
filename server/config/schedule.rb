require 'rails'
job_type :rake, 'cd :path && RAILS_ENV=:environment bundle exec rake :task :output'
set :output, '/var/log/whenever/whenever.log'
Time.zone = 'US/Eastern'

every 1.day, at: Time.zone.parse('11:00 am').utc.utc, roles: [:app] do
  rake 'fetch:articles'
end

every 1.day, at: Time.zone.parse('6:10 am').utc.utc, roles: [:app] do
  rake 'fetch:tweets'
end

every 1.day, at: Time.zone.parse('11:30 am').utc, roles: [:app] do
  rake 'fetch:tweets'
end

every 1.day, at: Time.zone.parse('3:00 pm').utc, roles: [:app] do
  rake 'fetch:tweets'
end

every 1.day, at: Time.zone.parse('6:00 pm').utc, roles: [:app] do
  rake 'fetch:articles'
end

every 1.day, at: Time.zone.parse('6:30 pm').utc, roles: [:app] do
  rake 'fetch:tweets'
end

every 1.day, at: Time.zone.parse('6:45 pm').utc, roles: [:app] do
  rake 'fetch:stock_prices'
end

every 1.day, at: Time.zone.parse('8:30 pm').utc, roles: [:app] do
  rake 'score:tweets'
end

every 1.day, at: Time.zone.parse('11:00 pm').utc, roles: [:app] do
  rake 'score:articles'
end