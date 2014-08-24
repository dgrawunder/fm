module DateFinder
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
end