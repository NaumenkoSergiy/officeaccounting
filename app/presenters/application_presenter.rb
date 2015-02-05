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

  def translate_select2_hash data
    data.collect{ |d| {value: d[1], text: t(d[0])} }
  end

  def translate_hash(hash)
    @credit_hash = Hash.new()
    hash.each do |key, value|
      @credit_hash[t(key)] = value
    end
    @credit_hash
  end

  def constant_parse(hash, data)
    t(hash.invert[data.to_sym])
  end

  private

  def i_name icon, name=nil
    "#{content_tag(:i, nil, class: "fa #{icon}")} #{name}".html_safe
  end

  def money_select(hash)
    hash.invert
        .collect do |key, value|
          {
            value: "#{key}",
            text:  "#{value}"
          }
        end
  end
end
