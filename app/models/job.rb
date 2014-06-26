class Job < ActiveRecord::Base
  has_many :job_tasks
  has_many :packages, :through => :job_tasks
  has_many :assignments
  has_many :users, :through => :assignments
end
