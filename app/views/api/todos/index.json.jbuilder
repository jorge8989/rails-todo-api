json.array! @todos do |todo|
  json.extract!(todo, :id, :text, :completed)
end