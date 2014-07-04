class JobsController < ApplicationController

  def show
    @job = Job.find(params[:id])
    $current_job_id = get_id
  end

  def index
    @jobs = Job.paginate(page: params[:page])
  end

  def apply
    if user_signed_in? == false
      flash[:alert] = "Please sign up or sign in to continue."
      redirect_to new_user_registration_path
    else
      @user = User.find(current_user.id)
      @job = Job.find($current_job_id)
      @job.users << @user
      flash[:success] = "You have successfully applied for this job. We will contact you as soon as we finish looking at your CV."
      redirect_to root_path
    end
  end

  def get_id
	id = request.original_url.split(/\/(\d{1,})/)
    id.last
  end

end
