require 'rails_helper'

describe ArticleFetcher::NewYorkTimes do
  include ActiveSupport::Testing::TimeHelpers

  it 'fetches articles from the New York Times article search API' do
    VCR.use_cassette('/models/article_fetcher/ny_times/fetch') do
      date = DateTime.parse('Sat, 04 Apr 2015 19:57:00 UTC +00:00 ')
      travel_to(date) do
        results = ArticleFetcher::NewYorkTimes.fetch('IBM')

        expect(results.size).to eq(1)

        link = 'http://www.nytimes.com/2015/04/02/business/klaus-tschira-business' <<
          '-software-trailblazer-dies-at-74.html'
        description = 'He and three colleagues formed a company that developed an' <<
          ' off-the-shelf software package to integrate all of a company&#8217;s business operations.'
        result = results.first
        expect(result.title).to eq('Klaus Tschira, Business Software Trailblazer, Dies at 74 ')
        expect(result.link).to eq(link)
        expect(result.description).to eq(description)
        expect(result.date).to eq('2015-04-04T00:00:00Z')
        expect(result.data['web_url']).to eq(link)
        expect(result.source).to eq('New York Times')
        expect(result.section).to eq(['Business Day'])
      end
    end
  end

end