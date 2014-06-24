class Job < ActiveRecord::Base
  has_many :job_tasks
  has_many :packages, :through => :job_tasks
end
