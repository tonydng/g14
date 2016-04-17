class Author < ActiveRecord::Base
	validates :author_name, presence: true
end
