require 'csv'
class StockReporter

  def self.send_report(stock_id, email)
    stock = Stock.find(stock_id)

    first_media_date =  [
      stock.articles.scored.any? ? stock.articles.scored.order(:date).first.date : DateTime.now,
      stock.tweets.scored.any? ?
        DateTime.parse(stock.tweets.scored.order("data->>'created_at'").first.data["created_at"]) :
        DateTime.now
    ].min

    start_date = first_media_date - 21.days

    stock_prices = stock.stock_prices.where("date >= ?", start_date).order("date DESC")
    stock_prices_hash = {}

    stock_prices.each do |stock_price|
      stock_prices_hash[stock_price.date.strftime("%m/%d/%Y")] = {
        open: stock_price.open,
        high: stock_price.days_high,
        low: stock_price.days_low,
        close: stock_price.close,
        volume: stock_price.volume,
        adj_close: stock_price.adj_close
      }
    end

    articles = stock.articles.scored.pluck(:date, :positivity_score)
    articles_hash = {}
    articles.each do |article|
      if articles_hash[article[0].strftime("%m/%d/%Y")]
        articles_hash[article[0].strftime("%m/%d/%Y")]["count"] += 1
        articles_hash[article[0].strftime("%m/%d/%Y")]["positivity_score"] += article[1]
      else
        articles_hash[article[0].strftime("%m/%d/%Y")] = {
          "count" => 1,
          "positivity_score" => article[1]
        }
      end
    end

    tweets = ActiveRecord::Base.connection.execute(
      "SELECT data->>'created_at' AS date, positivity_score FROM tweets WHERE tweets.stock_id = #{stock.id} AND positivity_score IS NOT NULL AND keywords::text IS NOT NULL"
    ).to_a
    tweets_hash = {}
    tweets.each do |tweet|
      if tweets_hash[DateTime.parse(tweet["date"]).strftime("%m/%d/%Y")]
        tweets_hash[DateTime.parse(tweet["date"]).strftime("%m/%d/%Y")]["count"] += 1
        tweets_hash[DateTime.parse(tweet["date"]).strftime("%m/%d/%Y")]["positivity_score"] += tweet["positivity_score"].to_f
      else
        tweets_hash[DateTime.parse(tweet["date"]).strftime("%m/%d/%Y")] = {
          "count" => 1,
          "positivity_score" => tweet["positivity_score"].to_f
        }
      end
    end

    reddits = stock.reddits.scored.pluck(:date, :positivity_score)
    reddits_hash = {}
    reddits.each do |reddit|
      if reddits_hash[reddit[0].strftime("%m/%d/%Y")]
        reddits_hash[reddit[0].strftime("%m/%d/%Y")]["count"] += 1
        reddits_hash[reddit[0].strftime("%m/%d/%Y")]["positivity_score"] += reddit[1]
      else
        reddits_hash[reddit[0].strftime("%m/%d/%Y")] = {
          "count" => 1,
          "positivity_score" => reddit[1]
        }
      end
    end
    dates_hash = {}
    date = DateTime.now
    while start_date.strftime("%m/%d/%Y") != date.strftime("%m/%d/%Y") do
      dates_hash[date.strftime("%m/%d/%Y")] = nil
      date -= 1.day
    end

    report = CSV.generate do |csv|
      csv << [
        "Date", "Open", "High", "Low", "Close", "Volume", "Adj Close",
        "Average Tweet Score", "Tweets Count", "Average Article Score",
        "Articles Count", "Average Reddits Score", "Reddits Count"
      ]
      dates_hash.each do |date, _|
        array = []
        array << date
        if stock_prices_hash[date]
          array << stock_prices_hash[date][:open]
          array << stock_prices_hash[date][:high]
          array << stock_prices_hash[date][:low]
          array << stock_prices_hash[date][:close]
          array << stock_prices_hash[date][:volume]
          array << stock_prices_hash[date][:adj_close]
        else
          array << nil
          array << nil
          array << nil
          array << nil
          array << nil
          array << nil
        end

        if tweets_hash[date]
          array << (tweets_hash[date]["positivity_score"].to_f / tweets_hash[date]["count"].to_f).round(2)
          array << tweets_hash[date]["count"]
        else
          array << nil
          array << nil
        end

        if articles_hash[date]
          array << (articles_hash[date]["positivity_score"].to_f / articles_hash[date]["count"].to_f).round(2)
          array << articles_hash[date]["count"]
        else
          array << nil
          array << nil
        end

        if reddits_hash[date]
          array << (reddits_hash[date]["positivity_score"].to_f / reddits_hash[date]["count"].to_f).round(2)
          array << reddits_hash[date]["count"]
        else
          array << nil
          array << nil
        end

        csv << array
      end
    end

    StockReportMailer.scores_report(email, stock.id, report).deliver_now
  end

end