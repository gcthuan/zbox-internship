class Question < ActiveRecord::Base
	validates :name, presence: true
	has_many :packagations
	has_many :packages, :through => :packagations 
	acts_as_taggable_on :tags
end
