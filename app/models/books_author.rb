class BooksAuthor < ActiveRecord::Base
	include ActiveModel::Validations
  belongs_to :book
  belongs_to :author
end
