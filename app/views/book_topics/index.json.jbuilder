json.array!(@book_topics) do |book_topic|
  json.extract! book_topic, :id, :book_id, :topic_id
  json.url book_topic_url(book_topic, format: :json)
end
