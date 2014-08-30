class ParsedDate < Virtus::Attribute

  def coerce(value)
    value.is_a?(Date) ? value : DateUtil.parse_date(value)
  end
end