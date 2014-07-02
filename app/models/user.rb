class User < ActiveRecord::Base
  belongs_to :job
  belongs_to :package
  validates :username, presence: true, length: { maximum: 50 }
  validates :cv, presence: true
  validates_datetime :deadline, :on_or_after => Time.current, :if => :is_cv_accepted?
  has_many :packagations
  mount_uploader :submission, SubmissionUploader
  mount_uploader :cv, CvUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_cv_accepted?
	status == "cv_accepted"
  end
end
