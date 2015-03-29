require 'csv'
class StockPriceResponse

  def initialize(csv)
    @parsed_csv = CSV.parse(csv).flatten
  end

  def open
    @parsed_csv[0]
  end

  def previous_close
    @parsed_csv[1]
  end

  def year_high
    @parsed_csv[2]
  end

  def year_low
    @parsed_csv[3]
  end

  def days_high
    @parsed_csv[4]
  end

  def days_low
    @parsed_csv[5]
  end

  def bid_realtime
    @parsed_csv[6]
  end

  def market_cap
    @parsed_csv[7]
  end

  def last_trade_price
    @parsed_csv[8]
  end

end