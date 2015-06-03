require 'rails_helper'

describe BingSearcher do

  include ActiveSupport::Testing::TimeHelpers

  it 'searches bing for new articles' do
    VCR.use_cassette('/models/bing_search_success') do
      date = DateTime.parse('Mon, 01 Jun 2015 19:57:00 UTC +00:00 ')
      travel_to(date) do
        results = BingSearcher.search_all('IBM')

        expect(results.size).to eq(124)
        expect(results.first.title).to eq('IBM-Affiliated Brooklyn School Graduates Its First Students Ahead of Schedule With Both High School & College STEM Degrees')
      end
    end
  end

end