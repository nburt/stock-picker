require 'rails_helper'

describe Article do

  describe 'validations' do

    before(:each) do
      @article = Article.new({stock_id: 1, title: 'Article', date: DateTime.now, link: 'link.com'})
    end

    it 'must have a stock_id' do
      expect(@article).to be_valid
      @article.stock_id = nil
      expect(@article).to_not be_valid
    end

    it 'must have a title' do
      expect(@article).to be_valid
      @article.title = nil
      expect(@article).to_not be_valid
    end

    it 'must have a date' do
      expect(@article).to be_valid
      @article.date = nil
      expect(@article).to_not be_valid
    end

    it 'must have a link' do
      expect(@article).to be_valid
      @article.link = nil
      expect(@article).to_not be_valid
    end

  end

  describe 'analyze!' do

    it 'pulls out keywords relating to an article and assigns it a score' do
      VCR.use_cassette('models/article/analyze') do
        article = create_article

        article.analyze!

        expect(article.positivity_score > 0).to eq(true)
        expect(article.keywords.size > 0).to eq(true)
        expect(article.sentiment).to eq({'score' => -0.08095166666666666, 'type' => 'negative'})
      end
    end

    it 'does not run an analysis if the article already has keywords or a positivity score' do
      article = create_article(keywords: ['keyword'], positivity_score: 50)
      expect(article.analyze!).to eq(false)
    end

    it 'does not run an analysis if the articles keywords have been set to an empty array' do
      article = create_article(keywords: [], positivity_score: nil)
      expect(article.analyze!).to eq(false)
    end

  end

  describe 'scored' do

    it 'returns articles with a positivity score' do
      article = create_article(stock_id: 1, keywords: ['keyword'], positivity_score: 50)
      create_article(stock_id: 2, keywords: ['keyword'])

      expect(Article.scored).to eq([article])
    end

  end

  describe 'unscored' do

    it 'returns articles with a positivity score' do
      article = create_article(stock_id: 1)
      create_article(stock_id: 2, positivity_score: 50, keywords: ['keyword'])

      expect(Article.unscored).to eq([article])
    end

    it 'does not return articles whose keywords are an empty array' do
      create_article(keywords: [])

      expect(Article.unscored).to eq([])
    end


  end

end