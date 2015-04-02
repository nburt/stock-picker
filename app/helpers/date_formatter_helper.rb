module DateFormatterHelper

  def format_date(date)
    if date.is_a?(String)
      DateTime.parse(date).strftime('%D (%A)')
    else
      date.strftime("%D (%A)")
    end
  end

end