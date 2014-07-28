module FmCli
  module FormatHelpers

    def format_date(date)
      date.strftime('%d.%m.%Y')
    end

    def format_currency amount
      format('%.2f €', amount)
    end
  end
end