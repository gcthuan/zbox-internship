class PackagesController < ApplicationController

  def show
  	@package = Package.find(params[:id])
	if auth_check
      if current_user.package != @package
      	flash[:alert] = "You can only view the test we prepared for you!"
      	redirect_to root_path
      end	
    end
  end

end
