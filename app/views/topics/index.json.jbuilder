json.array!(@topics) do |topic|
  json.extract! topic, :id, :topic_name
  json.url topic_url(topic, format: :json)
end
