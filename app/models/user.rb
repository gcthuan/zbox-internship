class User < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :job
  belongs_to :package
  validates :username, presence: true, length: { maximum: 50 }
  validates :cv, presence: true
  validates_datetime :deadline, :on_or_after => Time.current, :if => :is_status?
  has_many :packagations
  mount_uploader :submission, SubmissionUploader
  mount_uploader :cv, CvUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_status?
	  status == "cv_accepted" || status == "submission_uploaded"
  end
end
