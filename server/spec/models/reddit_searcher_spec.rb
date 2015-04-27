require 'rails_helper'

describe RedditSearcher do

  it 'searches the stocks subreddit for ticker symbols' do
    VCR.use_cassette('/models/reddit_searcher/success') do
      results = RedditSearcher.search('IBM')

      expect(results.size).to eq(23)

      expect(results.first.title).to eq("Assistance evaluating IBM's Watson Analytics?")
      expect(results.first.link).to eq('http://www.reddit.com/r/datascience/comments/33ylaf/assistance_evaluating_ibms_watson_analytics/')
      expect(results.first.date).to eq('Sun, 26 Apr 2015 23:35:49 -0600')
      expect(results.first.data).to_not be_nil
      expect(results.first.subreddit_id).to eq('t5_2sptq')
    end

  end

end