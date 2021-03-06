require 'rails_helper'

describe ArticleAnalyzer do

  it 'returns a list of keywords and a positivity score for an article' do
    VCR.use_cassette('/models/analyzer/article/success') do
      attributes = {
        stock_id: 1,
        title: "Strong dollar hurts HP's earnings forecast, shares plummet",
        description:
          "[Reuters] - \"Revenue was a little short on the top end, the guidance for the second quarter was a little below where the consensus was,\" said Daniel Morgan, a portfolio manager at Synovus Trust Co. The combined effect of those separation costs and the hit from the strong dollar will almost halve HP's free cash flow this fiscal year to about $3.5 billion to $4 billion, down from a forecast three months ago of $6.5 billion to $7 billion. Palo Alto-based HP follows Microsoft Corp and International Business Machines Corp in seeing a significant negative impact from the strong dollar. The computer and printer units, which will make up HP Inc under the separation plan, saw combined revenue fall 1.8 percent from the year-ago quarter to $14 billion, while the rest of the company, to be known as Hewlett-Packard Enterprise, saw revenue fall 4.9 percent to about $13.6 billion.",
        link:
          "http://us.rd.yahoo.com/finance/news/rss/story/*http://sg.finance.yahoo.com/news/strong-dollar-hurts-hps-earnings-073940904.html",
        date: "Wed, 25 Feb 2015 07:39:40 UTC +00:00",
      }

      article = create_article(attributes)
      analyzer = ArticleAnalyzer.new(article)
      analysis = analyzer.analyze!

      expect(analysis.keywords.size).to eq(136)
      expect(analysis.positivity_score > 0).to eq(true)
    end
  end

  it 'only analyzes the title if the description and link are blank' do
    VCR.use_cassette('/models/analyzer/article/title') do
      attributes = {
        stock_id: 1,
        title: 'Strong dollar hurts HP\'s earnings forecast, shares plummet',
        description: '',
        link: '',
        date: 'Wed, 25 Feb 2015 07:39:40 UTC +00:00',
      }

      article = create_article(attributes)
      analyzer = ArticleAnalyzer.new(article)
      analysis = analyzer.analyze!

      expect(analysis.keywords.size).to eq(4)
      expect(analysis.positivity_score > 0).to eq(true)
      expect(analysis.sentiment).to eq({score: -0.826981, type: 'negative'})
    end
  end

  it 'handles when keywords return an empty array' do
    VCR.use_cassette('/models/analyzer/article/error') do
      attributes = {
        stock_id: 1,
        title: 'AMERIPRISE FINANCIAL INC Financials',
        description: '',
        link: '',
        date: 'Wed, 25 Feb 2015 07:39:40 UTC +00:00',
      }

      article = create_article(attributes)
      analyzer = ArticleAnalyzer.new(article)
      analysis = analyzer.analyze!

      expect(analysis.keywords.size).to eq(0)
      expect(analysis.positivity_score).to eq(nil)
      expect(analysis.sentiment).to eq(nil)
    end
  end

  it 'returns still scores the description if the title returns nil for keywords' do
    VCR.use_cassette('/models/analyzer/article/description') do
      attributes = {
        stock_id: 1,
        title: '',
        description:
          "[Reuters] - \"Revenue was a little short on the top end, the guidance for the second quarter was a little below where the consensus was,\" said Daniel Morgan, a portfolio manager at Synovus Trust Co. The combined effect of those separation costs and the hit from the strong dollar will almost halve HP's free cash flow this fiscal year to about $3.5 billion to $4 billion, down from a forecast three months ago of $6.5 billion to $7 billion. Palo Alto-based HP follows Microsoft Corp and International Business Machines Corp in seeing a significant negative impact from the strong dollar. The computer and printer units, which will make up HP Inc under the separation plan, saw combined revenue fall 1.8 percent from the year-ago quarter to $14 billion, while the rest of the company, to be known as Hewlett-Packard Enterprise, saw revenue fall 4.9 percent to about $13.6 billion.",
        link: '',
        date: 'Wed, 25 Feb 2015 07:39:40 UTC +00:00',
      }

      article = create_article(attributes)
      analyzer = ArticleAnalyzer.new(article)
      analysis = analyzer.analyze!

      expect(analysis.keywords.size).to eq(39)
      expect(analysis.positivity_score).to eq(34.56)
      expect(analysis.sentiment).to eq({score: -0.436971, type: 'negative'})
    end
  end

end