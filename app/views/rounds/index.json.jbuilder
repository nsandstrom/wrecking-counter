json.array!(@rounds) do |round|
  json.extract! round, :id, :name, :active, :endtime, :score
end
