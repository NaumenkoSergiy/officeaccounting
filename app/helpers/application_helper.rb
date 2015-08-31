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

  def render_modal_window(title, form_id, list_id, id_button, tabs = '')
    render partial: 'shared/modal', locals: { title: title,
                                              form: "<div id='#{form_id}'></div>".html_safe,
                                              list: "<div id='#{list_id}'></div>".html_safe,
                                              id_button: id_button,
                                              tabs: tabs.html_safe }
  end

  def merge_class_name_for_select(types, class_name)
    types.map { |a| [t(a), class_name + a.to_s] }
  end

  def render_list(class_name, folder, array, variable)
    if can? :update, class_name
      render partial: folder + 'edit_list', collection: array, as: variable
    else
      render partial: folder + 'view_list', collection: array, as: variable
    end
  end

  def translate_subclasses_for_select2(data, parent_class)
    data.map {|s| [ t(s.name.gsub(parent_class, '')), s.name] }
  end

  def translate_subclasses_for_select(data, parent_class)
    data.map {|s| {text: t(s.name.gsub(parent_class, '')), value: s.name} }
  end

  def broadcast(channel, &block)
    message = {channel: channel, data: capture(&block)}
    uri = URI.parse(Rails.application.secrets.broadcast)
    Net::HTTP.post_form(uri, message: message.to_json)
  end
end
