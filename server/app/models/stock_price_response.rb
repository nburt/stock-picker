require 'csv'
class StockPriceResponse

  def initialize(row)
    @row = row
  end

  def date
    @row["Date"]
  end

  def open
    @row["Open"]
  end

  def days_high
    @row["High"]
  end

  def days_low
    @row["Low"]
  end

  def close
    @row["Close"]
  end

  def volume
    @row["Volume"]
  end

  def adj_close
    @row["Adj Close"]
  end

end