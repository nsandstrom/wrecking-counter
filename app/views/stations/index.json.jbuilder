json.array!(@stations) do |station|
  json.extract! station, :id, :location, :team_id, :boost, :active
  # json.url station_url(station, format: :json)
end
