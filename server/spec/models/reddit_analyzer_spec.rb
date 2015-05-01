require 'rails_helper'

describe RedditAnalyzer do

  it 'returns a list of keywords and a positivity score for a reddit' do
    VCR.use_cassette('models/reddit_analyzer/text') do
      reddit = create_reddit

      analyzer = RedditAnalyzer.new(reddit)
      analysis = analyzer.analyze!

      expect(analysis.keywords.size).to eq(16)
      expect(analysis.positivity_score > 0).to eq(true)
      expect(analysis.sentiment).to eq({score: 0.528219, type: 'positive'})
    end
  end

  it 'handles when keywords are empty and sentiment is nil' do
    allow_any_instance_of(RedditAnalyzer).to receive(:analyze_keywords).and_return([])
    allow_any_instance_of(RedditAnalyzer).to receive(:analyze_sentiment).and_return(nil)

    reddit = create_reddit

    analyzer = RedditAnalyzer.new(reddit)
    analysis = analyzer.analyze!

    expect(analysis.keywords).to eq([])
    expect(analysis.positivity_score).to eq(nil)
    expect(analysis.sentiment).to eq(nil)
  end

end