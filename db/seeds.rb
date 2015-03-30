# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: 'admin@example.com',
						password: 'password',
            password_confirmation: 'password',
						is_admin: true,
						activate_token: nil)
user.update_column(:activate_token, nil)

file = File.open('db/UkraineBanks.txt')
file.each do |form|
  form = eval form[0..-3]
  Bank.create({name: form[:name], code_edrpo: form[:code_edrpo], mfo: form[:mfo], lawyer_adress: form[:lawyer_adress] })
end

file = File.open('db/accounting_account.txt')
file.each do |form|
  form = eval(form[0..-3])
  AccountingAccount.create({account_number: form[:account_number], name: form[:name], ap: form[:ap], invoice_type: form[:type], subcount1: form[:subcount1], subcount2: form[:subcount2], subcount3: form[:subcount3]})
end
