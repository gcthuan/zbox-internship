class PackagesController < ApplicationController

  def show
	if auth_check
      @package = Package.find(params[:id])
    else
      flash[:alert] = "You need to sign in or sign up before continue."
    end
  end

end
