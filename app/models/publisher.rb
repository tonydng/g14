class Publisher < ActiveRecord::Base
	has_many :books, dependent: :destroy
	validates :name, presence: :true
	validates :location, presence: :true
end
