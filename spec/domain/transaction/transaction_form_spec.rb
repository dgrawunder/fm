describe TransactionForm do


  describe 'validation' do

    it { is_expected.to validate_presence_of :description }
    it { is_expected.to ensure_length_of(:description).is_at_most(35) }
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_inclusion_of(:type).in_array(TransactionType.numbers) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:day_of_month).is_greater_than(0).is_less_than(32).allow_nil }

    context 'when not being a template' do

      it { is_expected.to validate_presence_of :date }

      it 'must not have day_of_month' do
        subject.day_of_month = 1
        subject.valid?
        expect(subject.errors[:day_of_month]).to include I18n.t('errors.messages.present')
      end
    end

    context 'when being a template' do
      subject { TransactionForm.new(template: true) }

      it 'must not have accounting_period_id' do
        subject.accounting_period_id = 7
        subject.valid?
        expect(subject.errors[:accounting_period_id]).to include I18n.t('errors.messages.present')
      end

      it { is_expected.to validate_presence_of :day_of_month }

      it 'must not have date' do
        subject.date = Date.new
        subject.valid?
        expect(subject.errors[:date]).to include I18n.t('errors.messages.present')
      end
    end

    context 'when not being a template or a receivable' do
      it { is_expected.to validate_presence_of :accounting_period_id }
    end

    context 'when being a receivable' do
      subject { TransactionForm.new(type: TransactionType[:receivable]) }
      it 'must not have accounting_period_id' do
        subject.accounting_period_id = 7
        subject.valid?
        expect(subject.errors[:accounting_period_id]).to include I18n.t('errors.messages.present')
      end
    end

    it 'should ensure that Category with given id exists for given transaction_type' do
      subject.category_id = 5
      subject.type = TransactionType[:expense]
      expect(CategoryRepository).to receive(:exists_by_id_and_transaction_type?).
                                        with(subject.category_id, subject.type).and_return(false)
      subject.valid?
      expect(subject.errors[:category_id]).to include "doesn't exists"
    end

    it 'should ensure that AccountingPeriod with given id exists' do
      subject.accounting_period_id = 5
      expect(AccountingPeriodRepository).to receive(:exists_by_id?).
                                                with(subject.accounting_period_id).and_return(false)
      subject.valid?
      expect(subject.errors[:accounting_period_id]).to include "doesn't exists"
    end

    it 'should en sure that receivable cannot be template' do
      subject.template = true
      subject.type = TransactionType[:receivable]
      subject.valid?
      expect(subject.errors[:template]).to include 'cannot be a receivable'
    end
  end

  describe '#date=' do

    it 'should parse to date' do
      subject.date = '23.05'
      expect(subject.date).to eq Date.new(Time.now.year, 5, 23)
    end
  end

  describe '#date' do

    it 'should have default value of current date' do
      current_date = Date.new(2014, 02, 12)
      allow(Date).to receive(:today).and_return(current_date)
      expect(subject.date).to eq current_date
    end
  end

  describe '#expected' do

    it 'should have default value' do
      expect(subject.expected).to be false
    end
  end

  describe '#fixed' do

    it 'should have default value' do
      expect(subject.fixed).to be false
    end
  end

  describe '#template' do

    it 'should have default value' do
      expect(subject.template).to be false
    end
  end

  describe '#type' do

    it 'should have default value' do
      expect(subject.type).to eq TransactionType[:expense]
    end
  end

  describe '#resolve_category_name!' do

    context 'when category_name is given' do

      it 'should try to set most matching category_id for scope transaction_type' do
        expect(CategoryRepository).to receive(:search_id_by_name_and_transaction_type).
                                          with('Cate 7', subject.type).and_return(3)
        subject.category_name = 'Cate 7'
        subject.resolve_category_id!
        expect(subject.category_id).to eq 3
      end

      it 'should throw exception when no category is found' do
        expect(CategoryRepository).to receive(:search_id_by_name_and_transaction_type).
                                          with('Cate 7', subject.type).and_return(nil)

        subject.category_name = 'Cate 7'
        expect { subject.resolve_category_id! }.to raise_error UnknownCategoryError
      end
    end

    context 'when category_name is not given' do

      it 'should keep existing category_id' do
        subject.category_id = 7
        expect(CategoryRepository).not_to receive(:search_id_by_name_and_transaction_type)
        subject.resolve_category_id!
        expect(subject.category_id).to eq 7
      end
    end
  end

  describe '#resolve_accounting_period_name!' do

    context 'when accounting_period_name is given' do

      it 'should try to set most matching accounting_period_id for scope transaction_type' do
        expect(AccountingPeriodRepository).to receive(:search_id_by_name).
                                                  with('Cate 7').and_return(3)
        subject.accounting_period_name = 'Cate 7'
        subject.resolve_accounting_period_id!
        expect(subject.accounting_period_id).to eq 3
      end
    end

    context 'when accounting_period_name is not given' do

      it 'should keep existing accounting_period_id' do
        subject.accounting_period_id = 7
        expect(AccountingPeriodRepository).not_to receive(:search_id_by_name)
        subject.resolve_accounting_period_id!
        expect(subject.accounting_period_id).to eq 7
      end
    end
  end
end