require 'rails_helper'

describe Reddit do

  describe 'validations' do

    before(:each) do
      @reddit = new_reddit
    end

    it 'must have a stock_id' do
      expect(@reddit).to be_valid
      @reddit.stock_id = nil
      expect(@reddit).to_not be_valid
    end

    it 'must have a title' do
      expect(@reddit).to be_valid
      @reddit.title = nil
      expect(@reddit).to_not be_valid
    end

    it 'must have a date' do
      expect(@reddit).to be_valid
      @reddit.date = nil
      expect(@reddit).to_not be_valid
    end

    it 'must have a link' do
      expect(@reddit).to be_valid
      @reddit.link = nil
      expect(@reddit).to_not be_valid
    end

  end

  describe 'analyze!' do

    it 'pulls out keywords relating to a reddit and assigns it a score' do
      VCR.use_cassette('models/reddit/analyze') do
        reddit = create_reddit

        reddit.analyze!

        expect(reddit.positivity_score > 0).to eq(true)
        expect(reddit.keywords.size > 0).to eq(true)
        expect(reddit.sentiment).to eq({'score' => 0.528219, 'type' => 'positive'})
      end
    end

    it 'does not run an analysis if the reddit already has keywords or a positivity score' do
      reddit = create_reddit(keywords: ['keyword'], positivity_score: 50)
      expect(reddit.analyze!).to eq(false)
    end

    it 'does not run an analysis if the reddits keywords have been set to an empty array' do
      reddit = create_reddit(keywords: [], positivity_score: nil)
      expect(reddit.analyze!).to eq(false)
    end

  end

  describe 'scored' do

    it 'returns reddits with a positivity score' do
      reddit = create_reddit(stock_id: 1, keywords: ['keyword'], positivity_score: 50)
      create_reddit(stock_id: 2, keywords: ['keyword'])

      expect(Reddit.scored).to eq([reddit])
    end

  end

  describe 'unscored' do

    it 'returns reddits with a positivity score' do
      reddit = create_reddit(stock_id: 1, keywords: nil)
      create_reddit(stock_id: 2, positivity_score: 50, keywords: ['keyword'])

      expect(Reddit.unscored).to eq([reddit])
    end

    it 'does not return reddits whose keywords are an empty array' do
      create_reddit(keywords: [])

      expect(Reddit.unscored).to eq([])
    end

    it 'returns tweets whose keywords are nil' do
      reddit = create_reddit(keywords: nil)

      expect(Reddit.unscored).to eq([reddit])
    end

  end

end