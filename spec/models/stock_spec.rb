require 'rails_helper'

describe Stock do

  before(:each) do
    @stock = new_stock
  end

  describe 'validations' do

    it 'must have a name' do
      expect(@stock).to be_valid
      @stock.name = nil
      expect(@stock).to_not be_valid
    end

    it 'must have a ticker symbol' do
      expect(@stock).to be_valid
      @stock.ticker_symbol = nil
      expect(@stock).to_not be_valid
    end

    it 'must have a unique name and ticker symbol' do
      expect(@stock).to be_valid
      create_stock
      expect(@stock).to_not be_valid
      @stock.name = 'American Express'
      expect(@stock).to_not be_valid
      @stock.ticker_symbol = 'AXP'
      expect(@stock).to be_valid
    end

  end

end