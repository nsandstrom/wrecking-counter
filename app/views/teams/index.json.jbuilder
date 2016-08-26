json.array!(@teams) do |team|
  json.extract! team, :id, :name, :score, :short_name
  json.url team_url(team, format: :json)
end
