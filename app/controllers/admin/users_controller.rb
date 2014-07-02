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

  def mail
    @user = User.find(params[:id])
    @job = @user.job
    @questions = Question.tagged_with(@job.tag_list, :any => true)
    @test = @questions.order_by_rand.limit(1).all
    @package = Package.create(:name => "#{@user.email} test")
    @package.questions << @test
    @package.user = @user
    UserMailer.send_package(@user).deliver
    @user.update_attribute :status, "cv_accepted"
    @user.update_attribute :deadline, Time.current + 5.minutes
    flash[:success] = "Successfully sent."
    redirect_to '/admin/users/index'
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

  def update_password
    @user = User.find(current_user.id)
    if @user.update(user_params)
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end

  def get_id
    request.original_url.split(/\/(\d{1,})/).last
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.required(:user).permit(:password, :password_confirmation)
  end

end

end