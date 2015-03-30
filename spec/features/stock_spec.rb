require 'rails_helper'

feature 'creating and viewing stocks' do

  scenario 'a user can create a stock' do
    visit(root_path)
    click_link('Add Stock')
    fill_in('stock[name]', with: 'IBM')
    fill_in('stock[ticker_symbol]', with: 'IBM')
    click_button('Create Stock')
    expect(page).to have_content('IBM')
  end

  scenario 'a user can view the names of stocks on the page' do
    create_stock
    create_stock({name: 'American Express', ticker_symbol: 'AXP'})
    visit(root_path)
    expect(page).to have_content('Stocks')
    expect(page).to have_content('IBM')
    expect(page).to have_content('American Express')
    expect(page).to have_content('AXP')
  end

  scenario 'viewing an individual stocks page' do
    stock = create_stock({name: 'American Express', ticker_symbol: 'AXP'})
    stock_price = StockPrice.create!({
      stock_id: stock.id,
      open: "N/A",
      previous_close: "N/A",
      year_high: "N/A",
      year_low: "N/A",
      days_high: "N/A",
      days_low: "N/A",
      bid_realtime: "N/A",
      market_cap: "158.54B",
      last_trade_price: "160.40"
    })
    article = create_article({stock_id: stock.id})

    visit(stock_path(stock))

    expect(page).to have_content('American Express (AXP)')
    expect(page).to have_content(stock_price.open)
    expect(page).to have_content(stock_price.market_cap)
    expect(page).to have_content(stock_price.last_trade_price)
    expect(page).to have_content(article.title)
  end

end