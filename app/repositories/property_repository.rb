class PropertyRepository

  include BaseRepository

  class << self

    def find_value(key)
      record_class.where(key: key).first.try(:value)
    end

    def save_value(key, value)
      if record_class.where(key: key).exists?
      else
        record_class.create(key: key, value: value)
      end
    end
  end


end