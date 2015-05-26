require 'rails_helper'

describe StockReportMailer do

  let(:stock) { create_stock }
  let(:email) { 'waluigi@nintendo.com' }

  before(:each) do
    @email = StockReportMailer.scores_report(
      email, stock.id, 'Date,Open,High,Low,Close,Average Tweet Score,' <<
             'Tweets Count,Average Article Score,Articles Count' <<
             ',Average Reddits Score,Reddits Count'
    )
  end

  it 'has a body' do
    text = @email.text_part.body.raw_source
    expect(text).to include('See attached')
  end

  it 'has a subject' do
    expect(@email.subject).to eq("Report for #{stock.name}")
  end

  it 'is sent to the email' do
    expect(@email.to).to eq([email])
  end

  it 'is sent from reports@stockpicker.com' do
    expect(@email.from).to eq(['reports@stockpicker.com'])
  end

  it 'has an attachment' do
    expect(@email.attachments.first.filename).to eq('ibm.csv')
  end

end