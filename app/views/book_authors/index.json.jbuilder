json.array!(@book_authors) do |book_author|
  json.extract! book_author, :id, :book_id, :author_id
  json.url book_author_url(book_author, format: :json)
end
