module Fmc

  class << self
    def env
      ENV.fetch 'FMC_ENV', 'development'
    end
  end

end

I18n.enforce_available_locales = false