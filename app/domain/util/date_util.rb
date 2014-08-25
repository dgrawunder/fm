module DateUtil
  extend self

  def find_date(min, max, day_of_month)
    target_date = min.clone
    begin
      target_date = target_date.change(day: day_of_month)
    rescue ArgumentError
      target_date = target_date.change(day: 1)
    end

    if target_date < min
      target_date= target_date.change(month: max.month)
    end

    if target_date > max
      target_date = max
    end

    target_date
  end

  def parse_date value
    return nil unless value.is_a?(String)
    
    begin
      case value.split('.').size
        when 1
          Date.strptime(value, '%d')
        when 2
          Date.strptime(value, '%d.%m')
        when 3
          Date.strptime(value, '%d.%m.%Y')
        else
          nil
      end
    rescue ArgumentError
      nil
    end
  end
end