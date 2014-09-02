class ParsedDate < Virtus::Attribute

  def coerce(value)
    if value.is_a?(Date)
      value
    elsif value.is_a?(Time)
      Date.new(value.year, value.month, value.day)
    else
      DateUtil.parse_date(value)
    end
  end
end