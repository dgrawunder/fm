describe TransactionRepository do

  subject { TransactionRepository }

  it 'should have query method for every TransactionType requiring an AccountingPeriod id' do
    expense_1 = create(:expense, accounting_period_id: 5)
    expense_2 = create(:expense, accounting_period_id: 5)
    create(:expense, accounting_period_id: 6)
    income = create(:income, accounting_period_id: 5)
    inpayment = create(:inpayment, accounting_period_id: 5)
    outpayment = create(:outpayment, accounting_period_id: 5)

    expect(subject.expenses_by_accounting_period_id(5)).to eq [expense_1, expense_2]
    expect(subject.incomes_by_accounting_period_id(5)).to eq [income]
    expect(subject.inpayments_by_accounting_period_id(5)).to eq [inpayment]
    expect(subject.outpayments_by_accounting_period_id(5)).to eq [outpayment]
  end

  describe '::templates' do

    it 'should return all templates' do
      template_1 = create(:template)
      template_2 = create(:template)
      create(:expense)
      expect(subject.templates).to eq [template_1, template_2]

    end
  end

  describe '::receivables' do

    context 'if accounting_period_id given' do

      it 'should return all receivables with accounting_period_id' do
        receivable_1 = create(:transaction, receivable: true, repaid: true, accounting_period_id: 1)
        receivable_2 = create(:transaction, receivable: true, repaid: false, accounting_period_id: 1)
        create(:transaction, receivable: true, accounting_period_id: 2)
        create(:transaction, receivable: false, accounting_period_id: 1)

        expect(subject.receivables(accounting_period_id: 1)).to eq [receivable_1, receivable_2]
      end
    end

    context 'if only_open is true' do

      it 'should return all receivables not being repaid' do
        receivable_1 = create(:transaction, receivable: true, repaid: false, accounting_period_id: 1)
        create(:transaction, receivable: true, repaid: true, accounting_period_id: 2)
        receivable_2 = create(:transaction, receivable: true, repaid: false, accounting_period_id: 2)
        create(:transaction, receivable: false, accounting_period_id: 1)

        expect(subject.receivables(only_open: true)).to eq [receivable_1, receivable_2]
      end
    end

    context 'if accounting_period_id is given and only_open is true' do

      it 'should return all receivables with accounting_period_id not being repaid' do
        receivable_1 = create(:transaction, receivable: true, repaid: false, accounting_period_id: 1)
        create(:transaction, receivable: true, repaid: true, accounting_period_id: 1)
        create(:transaction, receivable: true, repaid: false, accounting_period_id: 2)
        create(:transaction, receivable: false, accounting_period_id: 1)

        expect(subject.receivables(accounting_period_id: 1, only_open: true)).to eq [receivable_1]
      end
    end

    context 'if accounting_period_id and only_open is not given' do

      it 'should return all receivables' do
        receivable_1 = create(:transaction, receivable: true, repaid: true, accounting_period_id: 1)
        receivable_2 = create(:transaction, receivable: true, repaid: false, accounting_period_id: 1)
        receivable_3 = create(:transaction, receivable: true, repaid: true, accounting_period_id: 2)
        create(:transaction, receivable: false, accounting_period_id: 1)
        create(:transaction, receivable: true, template: true)

        expect(subject.receivables).to(
            eq [receivable_1, receivable_2, receivable_3])
      end
    end
  end

  describe '::search' do

    it 'should return all Transaction if empty criteria given' do
      create(:expense)
      create(:income)
      create(:outpayment)
      criteria = TransactionSearchForm.new
      expect(subject.search(criteria).count).to eq 3
    end

    it 'should return all by given type and accounting_period_id and sort' do
      expense_3 = create(:expense, accounting_period_id: 2, date: 3.days.ago)
      expense_1 = create(:expense, accounting_period_id: 2, date: 1.days.ago)
      expense_2 = create(:expense, accounting_period_id: 2, date: 2.days.ago)
      create(:income, accounting_period_id: 2)
      create(:expense, accounting_period_id: 3)
      criteria = TransactionSearchForm.new(
          accounting_period_id: 2, type: TransactionType[:expense], sort: 'date desc')

      expect(subject.search(criteria)).to eq [expense_1, expense_2, expense_3]
    end

    it 'should set category if given as included association' do
      category_1 = create(:expense_category)
      category_2 = create(:income_category)
      create(:expense, category_id: category_1.id)
      create(:income, category_id: category_2.id)

      criteria = TransactionSearchForm.new
      actual_transactions = subject.search(criteria, include: :category)

      expect(actual_transactions.first.category).to eq category_1
      expect(actual_transactions.second.category).to eq category_2
    end

    context 'if term present' do

      it 'should use it as search term for description' do
        transaction_1 = create(:expense, description: 'A Food Store 1')
        transaction_2 = create(:expense, description: 'A Food Store 2')
        create(:expense)

        criteria = TransactionSearchForm.new(term: 'Food Store')
        expect(subject.search(criteria)).to eq [transaction_1, transaction_2]
      end

      it 'should use it as search term for amount' do
        transaction_1 = create(:expense, amount: 34.90)
        create(:expense, amount: 34.99)

        criteria = TransactionSearchForm.new(term: '34.90')
        expect(subject.search(criteria)).to eq [transaction_1]
      end

      it 'should use it as search term for category names' do
        category_1 = create(:expense_category, name: 'First Food Category')
        transaction_1 = create(:expense, category_id: category_1.id)
        create(:expense)

        criteria = TransactionSearchForm.new(term: 'Food')
        expect(subject.search(criteria)).to eq [transaction_1]
      end
    end

    context 'if expected present' do

      context 'if expected is true' do

        it 'should return only expected transactions' do
          transaction_1 = create(:expense, expected: true)
          transaction_2 = create(:expense, expected: true)
          create(:expense, expected: false)

          criteria = TransactionSearchForm.new(expected: true)
          expect(subject.search(criteria)).to eq [transaction_1, transaction_2]
        end
      end

      context 'if expected is false' do

        it 'should return all transaction where expected is nil or false' do
          transaction_1 = create(:expense, expected: false)
          transaction_2 = create(:expense, expected: nil)
          create(:expense, expected: true)

          criteria = TransactionSearchForm.new(expected: false)
          expect(subject.search(criteria)).to eq [transaction_1, transaction_2]
        end
      end
    end

    context 'if receivable present' do

      context 'if receivable is true' do

        it 'should return only receivable transactions' do
          transaction_1 = create(:outpayment, receivable: true)
          transaction_2 = create(:outpayment, receivable: true)
          create(:outpayment, receivable: false)

          criteria = TransactionSearchForm.new(receivable: true)
          expect(subject.search(criteria)).to eq [transaction_1, transaction_2]
        end
      end

      context 'if receivable is false' do

        it 'should return all transaction where receivable is nil or false' do
          transaction_1 = create(:expense, receivable: false)
          transaction_2 = create(:expense, receivable: nil)
          create(:expense, receivable: true)

          criteria = TransactionSearchForm.new(receivable: false)
          expect(subject.search(criteria)).to eq [transaction_1, transaction_2]
        end
      end
    end

    context 'if repaid present' do

      context 'if repaid is true' do

        it 'should return only receivable transactions' do
          transaction_1 = create(:outpayment, repaid: true)
          transaction_2 = create(:outpayment, repaid: true)
          create(:outpayment, repaid: false)

          criteria = TransactionSearchForm.new(repaid: true)
          expect(subject.search(criteria)).to eq [transaction_1, transaction_2]
        end
      end

      context 'if repaid is false' do

        it 'should return all transaction where repaid is nil or false' do
          transaction_1 = create(:expense, repaid: false)
          transaction_2 = create(:expense, repaid: nil)
          create(:expense, repaid: true)

          criteria = TransactionSearchForm.new(repaid: false)
          expect(subject.search(criteria)).to eq [transaction_1, transaction_2]
        end
      end
    end

    context 'if template present' do

      context 'if template is true' do

        it 'should return only template transactions' do
          transaction_1 = create(:template)
          transaction_2 = create(:template)
          create(:expense)

          criteria = TransactionSearchForm.new(template: true)
          expect(subject.search(criteria)).to eq [transaction_1, transaction_2]
        end
      end

      context 'if template is false' do

        it 'should return all transaction where template is nil or false' do
          transaction_1 = create(:expense, template: false)
          transaction_2 = create(:expense, template: nil)
          create(:template)

          criteria = TransactionSearchForm.new(template: false)
          expect(subject.search(criteria)).to eq [transaction_1, transaction_2]
        end
      end
    end
  end
end