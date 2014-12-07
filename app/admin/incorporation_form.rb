ActiveAdmin.register IncorporationForm do
  permit_params :number, :name

  form do |f|
    f.inputs do
      f.input :number
      f.input :name
    end
    f.actions
  end
end
