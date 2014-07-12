module EntityUseCaseHooks

  def self.included(base)
    base.extend ClassMethods
  end

  def before_validation
    self.class.before_validation_proc
  end

  def run_before_validation *args
    if before_validation.present?
      before_validation.call(*args)
    end
  end

  module ClassMethods

    def before_validation &block
      @before_validation_proc = block
    end

    def before_validation_proc
      @before_validation_proc
    end
  end

end