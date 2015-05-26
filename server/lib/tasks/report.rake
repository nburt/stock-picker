namespace :report do
  STOCK_IDS = [1, 4, 2, 7, 3, 6, 5, 8]
  desc "Send Stocks Report"
  task stocks: :environment do
    stocks = Stock.where(id: STOCK_IDS)
    count = stocks.size
    stocks.each_with_index do |stock, index|
      p "#{index + 1} out of #{count}"
      email = 'nathanael.burt@gmail.com'
      StockReporter.send_report(stock.id, email)
    end
  end
end