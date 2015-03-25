module AccountingAccountsHelper
  def render_accounting_accounts_list(accounting_accounts)
    if can? :update, AccountingAccount
      render partial: 'accounting_accounts/edit_list' , collection: accounting_accounts, as: :accounting_account
    else
      render partial: 'accounting_accounts/view_list', collection: accounting_accounts, as: :accounting_account
    end
  end
end
