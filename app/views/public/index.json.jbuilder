json.active_round do 
  json.extract! @active_round, :name, :active, :endtime if @active_round
end

json.coming_rounds(@coming_rounds) do |round|
json.extract! round, :name, :active, :starttime, :endtime if @coming_rounds
end

json.stations(@stations) do |station|
  json.extract! station, :id, :location, :owner, :boost, :active
end

json.teams(@teams) do |team|
	json.extract! team, :name, :short_name, :score, :colour
end