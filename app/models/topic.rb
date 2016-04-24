class Topic < ActiveRecord::Base
	has_many :books, dependent: :destroy
	validates :topic_name, presence: true
end
