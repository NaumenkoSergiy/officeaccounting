module ApplicationHelper
  def present(object, klass=nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def link_to_add_fields(name, f, type)
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def render_modal_window(title, form_id, list_id, id_button)
    render partial: 'shared/modal', locals: { title: title,
                                              form: "<div id='#{form_id}'></div>".html_safe,
                                              list: "<div id='#{list_id}' class='modal_list'></div>".html_safe,
                                              id_button: id_button }
  end
end
