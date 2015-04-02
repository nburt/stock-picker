require 'rails_helper'

describe ArticleFetcher do

  it 'fetches a list of articles about a stock and returns them as an array' do
    VCR.use_cassette('/models/article_fetcher/fetch') do
      results = ArticleFetcher.fetch('IBM')

      expect(results.size).to eq(20)

      link = 'http://us.rd.yahoo.com/finance/external/forbes/rss/SIG=13r71r6g6/*' +
        'http://www.forbes.com/sites/erikamorphy/2015/03/28/just-how-important-are' +
        '-mobile-shoppers-come-april-21-we-will-find-out/?utm_campaign=yahootix&partner=yahootix'
      result = results.first
      expect(result.title).to eq('Just How Important Are Mobile Shoppers? Come April 21, We Will Find Out')
      expect(result.link).to eq(link)
      expect(result.description).to eq('')
      expect(result.date).to eq('Sat, 28 Mar 2015 21:02:00 GMT')
    end
  end

end