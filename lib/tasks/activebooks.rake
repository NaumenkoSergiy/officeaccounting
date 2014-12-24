namespace :activebooks do
  task add_form_of_incorporation: :environment do
    Constants::FORMS_OF_INCORPORATION.each do |form|
      IncorporationForm.create(number: form[0..2], name: form[5..-1])
    end
  end
  
  task add_form_of_invoice: :environment do
    Constants_invoice::FORMS_OF_INVOICE.each do |form|
      InvoiceForm.create({account_number: form[:account_number], name: form[:name], invoice_type: form[:type], subcount1: form[:subcount1], subcount2: form[:subcount2] })
    end
  end

  task add_kved: :environment do
    file = File.read('lib/KVED.json')
    data_hash = JSON.parse(file)

    p 'Add data to the DB...'
    data_hash.each do |kved|
      if kved['КВЕД']
        name = kved['Наименование']
        Kved.create(
          section: kved['Секция'],
          number: kved['КВЕД'],
          name: name.kind_of?(Array) ? name.join(',') : name
        )
      end
    end
    p 'Complete!'
  end
end
