module FmCli
  module FormatHelpers

    def format_date(date)
      date.strftime('%d.%m.%Y')
    end

    def format_currency amount, expected: false
      formatted = format('%.2f €', amount)
      expected ? formatted.cyan : formatted
    end
  end
end