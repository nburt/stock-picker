require 'rails_helper'

describe TweetSearcher do

  it 'searches twitter for mentions of a stocks twitter handle' do
    VCR.use_cassette('/models/tweet_searcher/success') do
      searcher = TweetSearcher.new('@IBM')
      results = searcher.search

      expect(results.size).to eq(100)
      expect(results.first[:metadata]).to eq({:iso_language_code=>"und", :result_type=>"recent"})
    end
  end

end