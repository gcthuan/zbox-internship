class User < ActiveRecord::Base
  belongs_to :job
  belongs_to :package
  validates :username, presence: true, length: { maximum: 50 }
  mount_uploader :submission, SubmissionUploader
  mount_uploader :cv, CvUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
