require 'rails_helper'

describe DateFormatterHelper do

  describe 'format_date' do

    it 'takes a date and formats it to mm/dd/yy (day of week)' do
      date = DateTime.now
      formatted = format_date(date)
      expect(formatted).to eq(date.strftime('%D (%A)'))
    end

    it 'takes a date that is a string and formats it to mm/dd/yy (day of week)' do
      date = 'Wed Apr 01 18:22:42 +0000 2015'
      formatted = format_date(date)
      expect(formatted).to eq('04/01/15 (Wednesday)')
    end

  end

end