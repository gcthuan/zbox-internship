module Admin

class Admin::UsersController < BaseController
  before_filter :authenticate_user!
  autocomplete :package, :name, :full => true

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    $current_id = get_id
  end

  def edit
    @user = current_user
  end

  def send_test
    @user = User.find(params[:id])
    @job = @user.job
    @questions = Question.tagged_with(@job.tag_list, :any => true)
    @easy = @questions.where(difficulty: "Easy").all.order_by_rand.limit(1).all
    @medium = @questions.where(difficulty: "Medium").all.order_by_rand.limit(1).all
    @hard = @questions.where(difficulty: "Hard").all.order_by_rand.limit(1).all
    @package = Package.create(:name => "#{@user.email} test")
    @package.questions << @easy << @medium <<@hard
    @package.user = @user
    password = Devise.friendly_token.first(8)
    @user.update_attribute :status, "cv_accepted"
    @user.update_attribute :password, password
    UserMailer.send_package(@user).deliver
    @user.update_attribute :deadline, Time.current + 5.minutes
    flash[:success] = "Successfully sent."
    redirect_to '/admin/users/index'
  end

  def select_date
    $current_id = params[:id]
    @user = User.find(params[:id])
  end

  def send_appointment
    @user = User.find($current_id)
    @user.update_attribute :status, "submission_accepted"
    UserMailer.send_package(@user).deliver
    @user.update_attribute :status, "appointment_sent"
    puts params[:appointment_date]
    flash[:success] = "Successfully sent."
    redirect_to "/admin/jobs/index"
  end

  def add_package
    @user = User.find($current_id)
    @package = Package.find_by_name(params[:package_name])
    if @package.valid?
      @user.packages << @package
    end
    redirect_to action:'show', id: $current_id
  end

  def remove_package
    @user = User.find($current_id)
    @package = Package.find(params[:id])
    @user.packages.destroy(@package)
    redirect_to action:'show', id: $current_id
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
        redirect_to '/admin/users/index', notice: "User deleted."
    end
  end

  def update
    @user = User.find($current_id)
    #@user.update(user_params)
    date = user_params
    appointment_date = DateTime.new date["appointment_date(1i)"].to_i, date["appointment_date(2i)"].to_i,
                                    date["appointment_date(3i)"].to_i, date["appointment_date(4i)"].to_i, 
                                    date["appointment_date(5i)"].to_i

    @user.update_attribute :appointment_date, appointment_date
    redirect_to action: "send_appointment"
  end

  def get_id
    request.original_url.split(/\?id=(\d{1,})/).last
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.required(:user).permit(:password, :password_confirmation, :appointment_date)
  end

end

end