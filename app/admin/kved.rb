ActiveAdmin.register Kved do
  permit_params :section, :number, :name

  form do |f|
    f.inputs do
      f.input :section
      f.input :number
      f.input :name
    end
    f.actions
  end
end
