class Job < ActiveRecord::Base
  has_many :users
  acts_as_taggable_on :tags
end
