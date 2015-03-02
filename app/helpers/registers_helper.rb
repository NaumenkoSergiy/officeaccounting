module RegistersHelper
  def document_type(page = '')
    if page == 'costs'
      MoneyRegister::DOCUMENT_TYPE_COST
    else
      MoneyRegister::DOCUMENT_TYPE_INCOME
    end
  end

  def render_registers_list(registers)
    if can? :update, MoneyRegister
      render partial: "money/registers/edit_list" , collection: registers, as: :register
    else
      render partial: "money/registers/view_list", collection: registers, as: :register
    end
  end
end
