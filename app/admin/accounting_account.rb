ActiveAdmin.register AccountingAccount do
  permit_params :account_number, :name, :invoice_type, :subcount1, :subcount2

  form do |f|
    f.inputs do
      f.input :account_number
      f.input :ap
      f.input :name
      f.input :invoice_type
      f.input :subcount1
      f.input :subcount2
      f.input :subcount3
    end
    f.actions
  end
end
