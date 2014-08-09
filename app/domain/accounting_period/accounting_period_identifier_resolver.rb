class AccountingPeriodIdentifierResolver

  def self.resolve_to_id identifier
    if identifier.to_s == identifier.to_i.to_s
      identifier
    else
      AccountingPeriodRepository.search_id_by_name(identifier)
    end
  end
end