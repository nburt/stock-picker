require 'rails_helper'

feature 'CRUDing stocks' do

  scenario 'a user can create a stock' do
    pending
    visit(new_stock_path)
    fill_in('stock[name]', with: 'IBM')
    fill_in('stock[ticker_symbol]', with: 'IBM')
    fill_in('stock[twitter_handle]', with: '@IBM')
    click_button('Create Stock')
    expect(page).to have_content('IBM')
    expect(page).to have_content('@IBM')
  end

  scenario 'a user can view the names of stocks on the page' do
    pending
    create_stock
    create_stock({name: 'American Express', ticker_symbol: 'AXP'})
    visit(root_path)
    expect(page).to have_content('Stocks')
    expect(page).to have_content('IBM')
    expect(page).to have_content('American Express')
    expect(page).to have_content('AXP')
  end

  scenario 'viewing an individual stocks page' do
    pending
    stock = create_stock({name: 'American Express', ticker_symbol: 'AXP'})
    stock_price = StockPrice.create!({
      stock_id: stock.id,
      open: 'N/A',
      previous_close: 'N/A',
      year_high: 'N/A',
      year_low: 'N/A',
      days_high: 'N/A',
      days_low: 'N/A',
      bid_realtime: 'N/A',
      market_cap: '158.54B',
      last_trade_price: '160.40'
    })
    article = create_article({stock_id: stock.id})

    visit(stock_path(stock))

    expect(page).to have_content('American Express (AXP)')
    expect(page).to have_content(stock_price.open)
    expect(page).to have_content(stock_price.market_cap)
    expect(page).to have_content(stock_price.last_trade_price)
    expect(page).to have_content(article.title)
  end

  scenario 'a user can view the average positivity score for a company' do
    pending
    stock = create_stock({name: 'American Express', ticker_symbol: 'AXP'})
    create_article(stock_id: stock.id, positivity_score: 50.0)

    visit(stock_path(stock))

    expect(page).to have_content('Positivity Score')
    expect(page).to have_content('50.0')
  end

  scenario 'a user can edit a stock' do
    pending
    stock = create_stock({name: 'American Express', ticker_symbol: 'AXP'})

    visit(edit_stock_path(stock))

    fill_in('stock[twitter_handle]', with: '@AmericanExpress')
    click_button('Update Stock')

    expect(page).to have_content('@AmericanExpress')
  end

end
