namespace :search do

  desc "Search for Articles"
  task articles: :environment do
    stocks = Stock.all
    count = stocks.size
    stocks.each_with_index do |stock, index|
      p "#{index + 1} out of #{count}"
      stock.search_and_save_articles
    end
  end

end