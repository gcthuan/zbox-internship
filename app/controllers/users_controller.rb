class UsersController < ApplicationController
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
    if current_user.try(:admin?)
      @user = User.find(params[:id])
      UserMailer.send_package(@user).deliver
      flash[:success] = "Successfully sent."
      redirect_to '/users/index'
    else
      flash[:error] = "You do not have right to access this function."
      render '/users/index'
    end
  end

  def add_package
    if current_user.try(:admin?)
      @user = User.find($current_id)
      @package = Package.find(params[:package_id])
      if @package.valid?
        @user.packages << @package
      end
      render action:'show', id: $current_id
    else
      flash[:error] = "You do not have right to access this function."
    end
  end

  def remove_package
    if current_user.try(:admin?)
      @user = User.find($current_id)
      @package = Package.find(params[:id])
      @user.packages.destroy(@package)
      redirect_to action:'show', id: $current_id
    else
      flash[:error] = "You do not have right to access this function."
    end
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update(user_params)
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      render root_path
    else
      render "edit"
    end
  end

  def get_id
    id = request.original_url.split(/\/(\d{1,})/)
    id.last
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.required(:user).permit(:password, :password_confirmation)
  end
end
