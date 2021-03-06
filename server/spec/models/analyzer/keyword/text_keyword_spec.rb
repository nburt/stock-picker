require 'rails_helper'

describe Analyzer::Keyword::TextKeyword do

  it 'takes text and extracts keywords and entities from it' do
    VCR.use_cassette('/models/analyzer/keyword/text') do
      text = "[Reuters] - \"Revenue was a little short on the top end, the guidance" +
        " for the second quarter was a little below where the consensus was,\" " +
        "said Daniel Morgan, a portfolio manager at Synovus Trust Co. The combined " +
        "effect of those separation costs and the hit from the strong dollar will " +
        "almost halve HP's free cash flow this fiscal year to about $3.5 billion " +
        "to $4 billion, down from a forecast three months ago of $6.5 billion to " +
        "$7 billion. Palo Alto-based HP follows Microsoft Corp and International " +
        "Business Machines Corp in seeing a significant negative impact from the " +
        "strong dollar. The computer and printer units, which will make up HP Inc " +
        "under the separation plan, saw combined revenue fall 1.8 percent from the " +
        "year-ago quarter to $14 billion, while the rest of the company, to be " +
        "known as Hewlett-Packard Enterprise, saw revenue fall 4.9 percent to about $13.6 billion."

      analyzer = Analyzer::Keyword::TextKeyword.new(text)
      keywords = analyzer.analyze!

      expected = {
        text: 'Palo Alto-based HP',
        relevance: '0.938681',
        sentiment: {score: -0.220497, type: "negative"}
      }

      expect(keywords.first).to eq(expected)
      expect(keywords.size).to eq(39)
    end
  end

  it 'handles weird text' do
    VCR.use_cassette('/modes/analyzer/keyword/text_2') do
      text = 'Dow #Stocks Trend $CVX $PFE $KO $UNH $XOM $AAPL $IBM $JPM $MCD $NKE $CAT $VZ $CSCO $TRV $MMM $MSFT $GS $DIS  @ … …… http://t.co/DDu364Hu4w'

      analyzer = Analyzer::Keyword::TextKeyword.new(text)
      keywords = analyzer.analyze!

      expect(keywords).to eq([])
    end
  end

  it 'returns an array unless text is present' do
    text = ''

    analyzer = Analyzer::Keyword::TextKeyword.new(text)
    keywords = analyzer.analyze!

    expect(keywords).to eq([])
  end

  it 'raises an exception when the api key is out of requests' do
    VCR.use_cassette('/models/analyzer/keyword/api_limit_reached') do
      text = 'text'

      expect {
        Analyzer::Keyword::TextKeyword.new(text).analyze!
      }.to raise_exception(Analyzer::ApiLimitReached)
    end
  end

  it 'handles errors gracefully' do
    VCR.use_cassette('/models/analyzer/keyword/error') do
      # AlchemyAPI returns an error saying this isn't English, cause why not?

      text = 'AMERIPRISE FINANCIAL INC Financials'
      analyzer = Analyzer::Keyword::TextKeyword.new(text)
      keywords = analyzer.analyze!

      expect(keywords).to eq([])
    end
  end

end