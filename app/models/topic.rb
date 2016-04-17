class Topic < ActiveRecord::Base
	validates :topic_name, presence: true
end
