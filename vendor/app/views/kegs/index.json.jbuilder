json.array!(@kegs) do |keg|
  json.extract! keg, :kegweight, :kegtemp
  json.url keg_url(keg, format: :json)
end
