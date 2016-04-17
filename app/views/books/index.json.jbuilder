json.array!(@books) do |book|
  json.extract! book, :id, :book_title
  json.url book_url(book, format: :json)
end
