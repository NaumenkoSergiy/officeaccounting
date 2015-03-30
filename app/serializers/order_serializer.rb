class OrderSerializer < ActiveModel::Serializer
  attributes :id, :date, :bank, :currency, :total, :total_grn, :rate, :commission, :account_grn, :account_rate

  def currency
    I18n.t(object.currency)
  end

  def bank
    object.bank_name
  end

  def account_grn
    object.grn_account_name
  end

  def account_rate
    object.foreign_currency_account_name
  end
end
