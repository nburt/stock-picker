require 'rails_helper'

describe StockReporter do

  let(:email) { 'waluigi@nintendo.com' }

  it 'compiles a report with all the stock prices and positivity scores for a stock' do
    date = DateTime.parse('Sat, 04 Apr 2015 19:57:00 UTC +00:00 ')
    Timecop.freeze(date) do
      stock = create_stock
      create_stock_price(stock_id: stock.id, date: 22.days.ago)
      stock_price_2 = create_stock_price(stock_id: stock.id, date: 21.days.ago)
      stock_price_3 = create_stock_price(stock_id: stock.id, date: 1.day.ago)
      stock_price_4 = create_stock_price(stock_id: stock.id, date: DateTime.now)

      create_article(positivity_score: 50, keywords: ['Dino Jungle'],
                     date: 1.day.ago, stock_id: stock.id)
      create_article(positivity_score: 50, keywords: ['Dino Jungle'],
                     title: 'Article 2', description: 'description 2',
                     link: 'www.link.com', stock_id: stock.id, date: DateTime.now)
      create_article(positivity_score: 50, keywords: ['Dino Jungle'],
                     title: 'Article 3', description: 'description 3',
                     link: 'www.link3.com', stock_id: stock.id, date: DateTime.now)

      create_tweet(positivity_score: 50, keywords: ['Dino Jungle'],
                   data: {created_at: 1.day.ago}, stock_id: stock.id)
      create_tweet(positivity_score: 50, keywords: ['Dino Jungle'],
                   data: {created_at: DateTime.now}, stock_id: stock.id)
      create_tweet(positivity_score: 50, keywords: ['Dino Jungle'],
                   data: {created_at: DateTime.now}, stock_id: stock.id)

      create_reddit(positivity_score: 50, keywords: ['Dino Jungle'],
                    date: 1.day.ago, stock_id: stock.id)
      create_reddit(positivity_score: 50, keywords: ['Dino Jungle'],
                    stock_id: stock.id, date: DateTime.now)
      create_reddit(positivity_score: 50, keywords: ['Dino Jungle'],
                    stock_id: stock.id, date: DateTime.now)

      attachment = <<-CSV
Date,Open,High,Low,Close,Volume,Adj Close,Average Tweet Score,Tweets Count,Average Article Score,Articles Count,Average Reddits Score,Reddits Count
#{stock_price_4.date.strftime('%m/%d/%Y')},#{stock_price_4.open},#{stock_price_4.days_high},#{stock_price_4.days_low},#{stock_price_4.close},#{stock_price_4.volume},#{stock_price_4.adj_close},50.0,2,50.0,2,50.0,2
#{stock_price_3.date.strftime('%m/%d/%Y')},#{stock_price_3.open},#{stock_price_3.days_high},#{stock_price_3.days_low},#{stock_price_3.close},#{stock_price_3.volume},#{stock_price_3.adj_close},50.0,1,50.0,1,50.0,1
04/02/2015,,,,,,,,,,,,
04/01/2015,,,,,,,,,,,,
03/31/2015,,,,,,,,,,,,
03/30/2015,,,,,,,,,,,,
03/29/2015,,,,,,,,,,,,
03/28/2015,,,,,,,,,,,,
03/27/2015,,,,,,,,,,,,
03/26/2015,,,,,,,,,,,,
03/25/2015,,,,,,,,,,,,
03/24/2015,,,,,,,,,,,,
03/23/2015,,,,,,,,,,,,
03/22/2015,,,,,,,,,,,,
03/21/2015,,,,,,,,,,,,
03/20/2015,,,,,,,,,,,,
03/19/2015,,,,,,,,,,,,
03/18/2015,,,,,,,,,,,,
03/17/2015,,,,,,,,,,,,
03/16/2015,,,,,,,,,,,,
03/15/2015,,,,,,,,,,,,
#{stock_price_2.date.strftime('%m/%d/%Y')},#{stock_price_2.open},#{stock_price_2.days_high},#{stock_price_2.days_low},#{stock_price_2.close},#{stock_price_2.volume},#{stock_price_2.adj_close},,,,,,
      CSV
      expect(StockReportMailer).to receive(:scores_report).with(email, stock.id, attachment).and_call_original

      StockReporter.send_report(stock.id, email)
    end
  end

  it 'adds in dates that have media even if there is no stock price' do
    date = DateTime.parse('Sat, 04 Apr 2015 19:57:00 UTC +00:00 ')
    Timecop.freeze(date) do
      stock = create_stock
      create_stock_price(stock_id: stock.id, date: 23.days.ago)
      stock_price_2 = create_stock_price(stock_id: stock.id, date: 22.days.ago)
      stock_price_3 = create_stock_price(stock_id: stock.id, date: 1.day.ago)
      stock_price_4 = create_stock_price(stock_id: stock.id, date: DateTime.now)

      article = create_article(positivity_score: 50, keywords: ['Dino Jungle'],
                     date: 2.days.ago, stock_id: stock.id)

      create_tweet(positivity_score: 50, keywords: ['Dino Jungle'],
                   data: {created_at: 1.day.ago}, stock_id: stock.id)

      create_reddit(positivity_score: 50, keywords: ['Dino Jungle'],
                    date: 1.day.ago, stock_id: stock.id)
      create_reddit(positivity_score: 50, keywords: ['Dino Jungle'],
                    stock_id: stock.id, date: DateTime.now)

      attachment = <<-CSV
Date,Open,High,Low,Close,Volume,Adj Close,Average Tweet Score,Tweets Count,Average Article Score,Articles Count,Average Reddits Score,Reddits Count
#{stock_price_4.date.strftime('%m/%d/%Y')},#{stock_price_4.open},#{stock_price_4.days_high},#{stock_price_4.days_low},#{stock_price_4.close},#{stock_price_4.volume},#{stock_price_4.adj_close},,,,,50.0,1
#{stock_price_3.date.strftime('%m/%d/%Y')},#{stock_price_3.open},#{stock_price_3.days_high},#{stock_price_3.days_low},#{stock_price_3.close},#{stock_price_3.volume},#{stock_price_3.adj_close},50.0,1,,,50.0,1
#{article.date.strftime('%m/%d/%Y')},,,,,,,,,50.0,1,,
04/01/2015,,,,,,,,,,,,
03/31/2015,,,,,,,,,,,,
03/30/2015,,,,,,,,,,,,
03/29/2015,,,,,,,,,,,,
03/28/2015,,,,,,,,,,,,
03/27/2015,,,,,,,,,,,,
03/26/2015,,,,,,,,,,,,
03/25/2015,,,,,,,,,,,,
03/24/2015,,,,,,,,,,,,
03/23/2015,,,,,,,,,,,,
03/22/2015,,,,,,,,,,,,
03/21/2015,,,,,,,,,,,,
03/20/2015,,,,,,,,,,,,
03/19/2015,,,,,,,,,,,,
03/18/2015,,,,,,,,,,,,
03/17/2015,,,,,,,,,,,,
03/16/2015,,,,,,,,,,,,
03/15/2015,,,,,,,,,,,,
03/14/2015,,,,,,,,,,,,
#{stock_price_2.date.strftime('%m/%d/%Y')},#{stock_price_2.open},#{stock_price_2.days_high},#{stock_price_2.days_low},#{stock_price_2.close},#{stock_price_2.volume},#{stock_price_2.adj_close},,,,,,
      CSV
      expect(StockReportMailer).to receive(:scores_report).with(email, stock.id, attachment).and_call_original

      StockReporter.send_report(stock.id, email)
    end
  end

  it 'only reports on scored articles, tweets, and reddits' do
    date = DateTime.parse('Sat, 04 Apr 2015 19:57:00 UTC +00:00 ')
    Timecop.freeze(date) do
      stock = create_stock
      create_stock_price(stock_id: stock.id, date: 22.days.ago)
      stock_price_2 = create_stock_price(stock_id: stock.id, date: 21.days.ago)
      stock_price_3 = create_stock_price(stock_id: stock.id, date: 1.day.ago)
      stock_price_4 = create_stock_price(stock_id: stock.id, date: DateTime.now)

      create_article(positivity_score: 50, keywords: ['Dino Jungle'],
                     date: 1.day.ago, stock_id: stock.id)
      create_article(positivity_score: 50, keywords: ['Dino Jungle'],
                     title: 'Article 2', description: 'description 2',
                     link: 'www.link.com', stock_id: stock.id, date: DateTime.now)
      create_article(title: 'Article 3', description: 'description 3',
                     link: 'www.link3.com', stock_id: stock.id, date: DateTime.now)

      create_tweet(positivity_score: 50, keywords: ['Dino Jungle'],
                   data: {created_at: 1.day.ago}, stock_id: stock.id)
      create_tweet(positivity_score: 50, keywords: ['Dino Jungle'],
                   data: {created_at: DateTime.now}, stock_id: stock.id)
      create_tweet(data: {created_at: DateTime.now}, stock_id: stock.id)

      create_reddit(positivity_score: 50, keywords: ['Dino Jungle'],
                    date: 1.day.ago, stock_id: stock.id)
      create_reddit(stock_id: stock.id, date: DateTime.now)
      create_reddit(positivity_score: 50, keywords: ['Dino Jungle'],
                    stock_id: stock.id, date: DateTime.now)

      attachment = <<-CSV
Date,Open,High,Low,Close,Volume,Adj Close,Average Tweet Score,Tweets Count,Average Article Score,Articles Count,Average Reddits Score,Reddits Count
#{stock_price_4.date.strftime('%m/%d/%Y')},#{stock_price_4.open},#{stock_price_4.days_high},#{stock_price_4.days_low},#{stock_price_4.close},#{stock_price_4.volume},#{stock_price_4.adj_close},50.0,1,50.0,1,50.0,1
#{stock_price_3.date.strftime('%m/%d/%Y')},#{stock_price_3.open},#{stock_price_3.days_high},#{stock_price_3.days_low},#{stock_price_3.close},#{stock_price_3.volume},#{stock_price_3.adj_close},50.0,1,50.0,1,50.0,1
04/02/2015,,,,,,,,,,,,
04/01/2015,,,,,,,,,,,,
03/31/2015,,,,,,,,,,,,
03/30/2015,,,,,,,,,,,,
03/29/2015,,,,,,,,,,,,
03/28/2015,,,,,,,,,,,,
03/27/2015,,,,,,,,,,,,
03/26/2015,,,,,,,,,,,,
03/25/2015,,,,,,,,,,,,
03/24/2015,,,,,,,,,,,,
03/23/2015,,,,,,,,,,,,
03/22/2015,,,,,,,,,,,,
03/21/2015,,,,,,,,,,,,
03/20/2015,,,,,,,,,,,,
03/19/2015,,,,,,,,,,,,
03/18/2015,,,,,,,,,,,,
03/17/2015,,,,,,,,,,,,
03/16/2015,,,,,,,,,,,,
03/15/2015,,,,,,,,,,,,
#{stock_price_2.date.strftime('%m/%d/%Y')},#{stock_price_2.open},#{stock_price_2.days_high},#{stock_price_2.days_low},#{stock_price_2.close},#{stock_price_2.volume},#{stock_price_2.adj_close},,,,,,
      CSV
      expect(StockReportMailer).to receive(:scores_report).with(email, stock.id, attachment).and_call_original

      StockReporter.send_report(stock.id, email)
    end
  end

end