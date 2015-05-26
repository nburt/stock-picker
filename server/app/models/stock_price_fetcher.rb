require 'csv'
class StockPriceFetcher

  def self.fetch!(ticker_symbol, date)
    url = url(ticker_symbol, date)
    response = Typhoeus::Request.get(url, {followlocation: true})
    csv = response.body
    CSV.parse(csv, headers: true).map do |row|
      StockPriceResponse.new(row)
    end
  end

  private

  def self.url(ticker_symbol, date)
    today = DateTime.now
    "http://real-chart.finance.yahoo.com/table.csv?s=#{ticker_symbol}&a=" <<
      "#{date.month - 1}&b=#{date.day}&c=#{date.year}&d=#{today.month - 1}&e=" <<
      "#{today.day}&f=#{today.year}&g=d&ignore=.csv"
  end



end