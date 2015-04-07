stocks = [
  {
    name: "IBM",
    ticker_symbol: "IBM"
  },
  {
    name: "American Express",
    ticker_symbol: "AXP"
  },
  {
    name: "Johnson & Johnson",
    ticker_symbol: "JNJ"
  },
  {
    name: "Ameriprise Financial, Inc.",
    ticker_symbol: "AMP"
  },
  {
    name: "Symantec Corporation",
    ticker_symbol: "SYMC"
  },
  {
    name: "Pfizer",
    ticker_symbol: "PFE"
  },
  {
    name: "Hewlett-Packard Company",
    ticker_symbol: "HPQ"
  },
  {
    name: "Lexmark International Inc",
    ticker_symbol: "LXK"
  }
]

stocks.each do |stock|
  Stock.create!(stock)
end