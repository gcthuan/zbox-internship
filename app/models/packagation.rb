class Packagation < ActiveRecord::Base
	belongs_to :question
	belongs_to :package
end
