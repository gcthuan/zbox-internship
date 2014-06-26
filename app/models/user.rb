class User < ActiveRecord::Base
  has_many :tasks
  has_many :packages, :through => :tasks
  has_many :assignments
  has_many :jobs, :through => :assignments
  
  mount_uploader :submission, SubmissionUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	#def update_with_password(params, *options)
	 # self.update_attribute :status, "Submitted"
	#end
end
