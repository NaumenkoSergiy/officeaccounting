ActiveAdmin.register Article do
  permit_params :code, :name

  form do |f|
    f.inputs do
      f.input :code
      f.input :name
    end
    f.actions
  end
end
