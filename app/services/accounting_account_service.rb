class AccountingAccountService < BaseService
  def accounts_for_select2(data)
    json = AccountingAccount.select(:id, :account_number)
    data[:type] == 'children' ? children(json) : all_accounts(json)
  end

  def all_accounts(json)
    json.map { |a| { value: a.id, text: a.account_number.to_s } }
        .sort_by { |a| a[:account_number] }
  end

  def children(json)
    json.map { |a| { value: a.id, text: a.account_number.to_s } if a.children.empty? }
        .compact
        .sort_by { |a| a[:account_number] }
  end
end
