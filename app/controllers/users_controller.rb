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

  def submit
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to root_path
    else
      render "submit"
    end
  end


  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.required(:user).permit(:password, :password_confirmation)
  end
end
