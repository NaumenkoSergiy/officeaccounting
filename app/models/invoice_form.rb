class InvoiceForm < ActiveRecord::Base
  has_many :payment_orders
end
