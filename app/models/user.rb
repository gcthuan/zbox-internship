class User < ActiveRecord::Base
  has_many :tasks
  has_many :packages, :through => :tasks
  has_many :assignments
  has_many :jobs, :through => :assignments
  validates :username, presence: true, length: { maximum: 50 }
  mount_uploader :submission, SubmissionUploader
  mount_uploader :cv, CvUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
