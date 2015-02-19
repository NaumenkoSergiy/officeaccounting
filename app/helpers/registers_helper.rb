module RegistersHelper
  def document_type(page)
    if page == 'costs'
      MoneyRegister::DOCUMENT_TYPE_COST
    else
      MoneyRegister::DOCUMENT_TYPE_INCOME
    end
  end
end
