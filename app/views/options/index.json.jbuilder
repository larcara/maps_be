json.array!(@options) do |option|
  json.extract! option, :id, :museum_id, :name, :key, :value
  json.url option_url(option, format: :json)
end
