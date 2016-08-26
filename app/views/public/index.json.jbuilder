json.round do 
  json.extract! @round, :name, :active, :endtime if @round
end

json.stations(@stations) do |station|
  json.extract! station, :id, :location, :owner, :boost, :active
end

json.teams(@teams) do |team|
	json.extract! team, :name, :short_name, :score, :colour
end