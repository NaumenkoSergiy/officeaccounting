json.array!(@registers) do |register|
  json.extract! register, :id, :date, :counterpaty_id, :operations, :value, :holding, :notes
  json.url register_url(register, format: :json)
end
