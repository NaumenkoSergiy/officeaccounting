class ApplicationPresenter
  include ActionView::Helpers

  def nav_link_to path, icon, name
    link_to content_tag(:div, i_name(icon, name), class: 'nav-label'), path
  end

  def destroy_link path
    link_to content_tag(:nav, i_name('fa-trash'), class: 'record-remove white'), path, method: :delete, remote: true, data: {confirm: 'Впевнені?'}
  end

  def options_for_select2 data
    data.collect{ |d| {value: d[1], text: d[0]} }
  end

  private

  def i_name icon, name=nil
    "#{content_tag(:i, nil, class: "fa #{icon}")} #{name}".html_safe
  end
end
