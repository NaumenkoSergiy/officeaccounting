unless Rails.env.production?
  Nomenclature::Equipment
  Nomenclature::Material
  Nomenclature::Product
  Nomenclature::Production
  Nomenclature::Service
  Employee::Basic_place
  Employee::Part
end
