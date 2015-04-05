require 'rails_helper'

describe Analyzer::Keyword::UrlKeyword do

  it 'takes text and extracts keywords and entities from it' do
    VCR.use_cassette('/models/analyzer/url_keyword/url') do
      url = 'http://us.rd.yahoo.com/finance/news/rss/story/*http://sg.finance.' +
        'yahoo.com/news/strong-dollar-hurts-hps-earnings-073940904.html'

      analyzer = Analyzer::Keyword::UrlKeyword.new(url)
      keywords = analyzer.analyze!

      expected = {
        text: 'historical chart data',
        relevance: '0.914685',
        sentiment: {score: 0.0, type: 'neutral'}
      }

      expect(keywords.first).to eq(expected)
      expect(keywords.size).to eq(93)
    end
  end

  it 'handles invalid urls' do
    VCR.use_cassette('/modes/analyzer/url_keyword/url_2') do
      url = 'text'

      analyzer = Analyzer::Keyword::UrlKeyword.new(url)
      keywords = analyzer.analyze!

      expect(keywords).to eq([])
    end
  end

  it 'returns an array unless text is present' do
    url = ''

    analyzer = Analyzer::Keyword::UrlKeyword.new(url)
    keywords = analyzer.analyze!

    expect(keywords).to eq([])
  end

end