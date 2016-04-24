json.array!(@books) do |book|
  json.extract! book, :id, :book_name, :publisher_id, :topic_id
  json.url book_url(book, format: :json)
end
