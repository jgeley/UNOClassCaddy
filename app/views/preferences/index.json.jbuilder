json.array!(@preferences) do |preference|
  json.extract! preference, :kind, :startTime, :endTime, :sessionid
  json.url preference_url(preference, format: :json)
end