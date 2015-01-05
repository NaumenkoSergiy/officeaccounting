ActiveAdmin.register Banks do
  permit_params :name, :code_edrpo, :mfo, :lawyer_adress

  form do |f|
    f.inputs do
      f.input :name
      f.input :code_edrpo
      f.input :mfo
      f.input :lawyer_adress
    end
    f.actions
  end
end
