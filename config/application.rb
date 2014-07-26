module Fm

  class << self
    def env
      ENV.fetch 'FM_ENV', 'development'
    end
  end

end

I18n.enforce_available_locales = false