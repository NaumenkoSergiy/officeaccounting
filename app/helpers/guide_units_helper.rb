module GuideUnitsHelper
  def render_guide_units_list(guide_units)
    if can? :update, AccountingAccount
      render partial: 'guide_units/edit' , collection: guide_units, as: :guide_unit
    else
      render partial: 'guide_units/view', collection: guide_units, as: :guide_unit
    end
  end
end
