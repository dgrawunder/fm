module EntityUseCaseHooks

  def self.included(base)
    base.extend ClassMethods
  end

  def before_validation
    self.class.before_validation_proc
  end

  def after_save
    self.class.after_save_proc
  end

  def run_before_validation *args
    if before_validation.present?
      before_validation.call(*args)
    end
  end

  def run_after_save *args
    if after_save.present?
      after_save.call(*args)
    end
  end

  module ClassMethods

    def before_validation &block
      @before_validation_proc = block
    end

    def before_validation_proc
      @before_validation_proc
    end

    def after_save &block
      @after_save_proc = block
    end

    def after_save_proc
      @after_save_proc
    end
  end

end