class ApplicationPresenter
  include ActionView::Helpers

  def nav_link_to path, icon, name
    link_to content_tag(:div, i_name(icon, name), class: 'nav-label'), path
  end

  def i_name icon, name
    "#{content_tag(:i, nil, class: "fa #{icon}")} #{name}".html_safe
  end
end
