module Fmd

  class << self
    def env
      ENV.fetch 'FMD_ENV', 'development'
    end
  end

end

I18n.enforce_available_locales = false