class Package < ActiveRecord::Base
	has_many :packagations
	has_many :tasks
	has_many :questions, :through => :packagations
	has_many :users, :through => :tasks
end
