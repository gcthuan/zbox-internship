class Job < ActiveRecord::Base
  include PublicActivity::Common

  has_many :users
  acts_as_taggable_on :tags
end
