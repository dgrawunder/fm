module DateParser
  extend self

  def parse value
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