module RegistersHelper
  def document_type
    if params[:page] == 'costs'
      MoneyRegister::DOCUMENT_TYPE_COST
    else
      MoneyRegister::DOCUMENT_TYPE_INCOME
    end
  end
end
