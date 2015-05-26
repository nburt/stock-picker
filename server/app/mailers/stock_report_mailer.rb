class StockReportMailer < ActionMailer::Base
  default from: 'reports@stockpicker.com'

  def scores_report(email, stock_id, attachment)
    stock = Stock.find(stock_id)
    attachments["#{stock.name.downcase}.csv"] = attachment
    mail(to: email, body: "See attached", subject: "Report for #{stock.name}")
  end

end