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
      end
    end

    it 'does not run an analysis if the article already has keywords or a positivity score' do
      article = create_article(keywords: ['keyword'], positivity_score: 50)
      expect(article.analyze!).to eq(false)
    end

  end

end