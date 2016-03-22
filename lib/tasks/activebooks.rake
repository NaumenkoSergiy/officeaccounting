namespace :activebooks do
  task add_form_of_incorporation: :environment do
    Constants::FORMS_OF_INCORPORATION.each do |form|
      IncorporationForm.create(number: form[0..2], name: form[5..-1])
    end
  end

  task add_kved: :environment do
    file = File.read('lib/KVED.json')
    data_hash = JSON.parse(file)

    data_hash.each do |kved|
      next unless kved['КВЕД'].present?
      name = kved['Наименование']
      Kved.create(
        section: kved['Секция'],
        number: kved['КВЕД'],
        name: name.is_a?(Array) ? name.join(',') : name
      )
    end
  end

  task add_koatuu: :environment do
    file = File.open('lib/KOATUU.txt')
    file.each do |line|
      line.delete!("\n").delete!("\t")
      Koatuu.create(code: line[0..8], name: line[10..-1])
    end
  end

  task add_tax_inspection: :environment do
    file = File.open('lib/CodesNalogovixInspekciyUkraine.txt')
    file.each do |line|
      TaxInspection.create(name: line[15..-2].strip)
    end
  end

  task add_form_of_article: :environment do
    Constants::FORMS_OF_ARTICLE.each do |form|
      Article.create(code: form[:code], name: form[:name])
    end
  end

  task encrypt_user_password: :environment do
    User.all.each do |user|
      user.password = user.confirm_password
      user.save
    end
  end

  task all: [:add_form_of_incorporation,
             :add_kved,
             :add_koatuu,
             :add_tax_inspection,
             :add_form_of_article]
end
