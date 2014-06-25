module Admin
  class BaseController < ApplicationController
    before_filter :verify_admin
	private
	def verify_admin
  	  unless current_user.try(:admin?)
  	  	flash[:alert] = "You are not authorized to access this action."
  	  	redirect_to root_path
  	  end
	end
  end
end