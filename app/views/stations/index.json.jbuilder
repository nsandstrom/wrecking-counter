json.array!(@stations) do |station|
  json.extract! station, :id, :location, :team_id, :boost
  json.url station_url(station, format: :json)
end
