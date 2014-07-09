class Package < ActiveRecord::Base
  has_many :packagations
  has_many :questions, :through => :packagations
  belongs_to :users
end
