json.array!(@authors) do |author|
  json.extract! author, :id, :author_name
  json.url author_url(author, format: :json)
end
