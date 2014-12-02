class BalanceReport

  attr_reader :accounting_period

  def initialize accounting_period
    @accounting_period = accounting_period
  end

  TransactionType.names.each do |type_name|
    plural_type_name = type_name.to_s.pluralize

    public

    # Defines methods like expenses for every TransactionType
    define_method plural_type_name do
      send("#{type_name}_transaction_sums").actual_sum
    end

    # Defines methods like total_expected_expenses for every TransactionType
    define_method "total_expected_#{plural_type_name}" do
      send("#{type_name}_transaction_sums").total_expected_sum
    end

    private

    # Defines methods like expense_transaction_sums for every TransactionType
    define_method "#{type_name}_transaction_sums" do
      instance_variable = "@#{type_name}_transaction_sums"
      instance_variable_get(instance_variable) ||
          instance_variable_set(instance_variable, get_transaction_sums(type_name))
    end
  end

  public

  def open_receivables
    get_open_receivables_sums.actual_sum
  end

  def total_expected_open_receivables
    get_open_receivables_sums.total_expected_sum
  end

  def balance
    @balance ||= (incomes - expenses)
  end

  def total_expected_balance
    @total_expected_balance ||= (total_expected_incomes - total_expected_expenses)
  end

  def credit
    @credit ||= begin
      accounting_period.initial_deposit + incomes + inpayments - expenses - outpayments
    end
  end

  def total_expected_credit
    @total_expected_credit ||= begin
      accounting_period.initial_deposit + total_expected_incomes + total_expected_inpayments -
          total_expected_expenses - total_expected_outpayments
    end
  end

  def credit_including_open_receivables
    @credit_including_open_receivables ||= begin
      credit + open_receivables
    end
  end

  def total_expected_credit_including_total_expected_open_receivables
    @total_expected_credit_including_receivables ||= begin
      total_expected_credit + total_expected_open_receivables
    end
  end

  private

  def get_open_receivables_sums
    @open_receivable_sums ||= begin
      transactions = TransactionRepository.receivables(accounting_period_id: accounting_period.id, only_open: true)
      TransactionSums.create(transactions)
    end
  end

  def get_transaction_sums(type_name)
    transactions = TransactionRepository.public_send("#{type_name.to_s.pluralize}_by_accounting_period_id",
                                                     accounting_period.id)
    TransactionSums.create(transactions)
  end
end