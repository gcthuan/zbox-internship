class UsersController < ApplicationController
  before_filter :authenticate_user!
  autocomplete :package, :name, :full => true
  autocomplete :job, :name, :full => true
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "You have successfully submitted your answer. Please wait while we can take a look at it."
      @user.update_attribute :status, "submission_uploaded"
      redirect_to :back
    else
      flash[:alert] = "Submission time is over!"
      redirect_to :back
    end
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.required(:user).permit(:password, :password_confirmation, :job_name, :submission, :appointment_date)
  end
end
