class Package < ActiveRecord::Base
	has_many :packagations
	has_many :questions, :through => :packagations 
end
