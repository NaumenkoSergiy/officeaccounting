json.array!(@counterparties) do |counterparty|
  json.extract! counterparty, :id, :name, :start_date, :active
  json.url counterparty_url(counterparty, format: :json)
end
