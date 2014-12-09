class RefactorReceivables < ActiveRecord::Migration

  def self.up
    current_accounting_period_id = PropertyRepository.find_current_accounting_period_id
    say_with_time 'Make all transactions with of type receivable to outpayments of the current accounting period' do
      ActiveRecordMapper::Transaction.
          where(type: 5).update_all(accounting_period_id: current_accounting_period_id,
                                    receivable: true,
                                    type: TransactionType[:outpayment],
                                    template: false
      )
    end

    def self.down

    end
  end
end