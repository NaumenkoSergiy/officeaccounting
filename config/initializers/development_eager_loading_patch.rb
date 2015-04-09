unless Rails.env.production?
  Nomenclature::Equipment
  Nomenclature::Material
  Nomenclature::Product
  Nomenclature::Production
  Nomenclature::Service
end
