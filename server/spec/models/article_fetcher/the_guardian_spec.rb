require 'rails_helper'

describe ArticleFetcher::TheGuardian do
  include ActiveSupport::Testing::TimeHelpers

  it 'fetches articles from the guardian news api' do
    VCR.use_cassette('/models/article_fetcher/the_guardian_success') do
      date = DateTime.parse('Sat, 04 Apr 2015 19:57:00 UTC +00:00 ')
      travel_to(date) do
        results = ArticleFetcher::TheGuardian.fetch('IBM')

        expect(results.size).to eq(2)
        expect(results.first.title).to eq("Tim Cook's activism is changing Apple – but his future may depend on a watch")
        expect(results.first.section).to eq(['Technology'])
        expect(results.first.link).to eq('http://www.theguardian.com/technology/2015/apr/04/tim-cook-activism-steve-jobs-apple-watch')
        expect(results.first.date).to eq('2015-04-04T12:00:04Z')
      end
    end
  end

end