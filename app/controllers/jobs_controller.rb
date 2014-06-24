class JobsController < ApplicationController
  autocomplete :package, :name, :full => true
  def new
    if current_user.try(:admin?)
      @job = Job.new
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def index
    if current_user.try(:admin?)
  	  @jobs = Job.paginate(page: params[:page])
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def show
    if auth_check
      @job = Job.find(params[:id])
      $current_id = get_id
    else
      flash[:alert] = "You need to sign in or sign up before continue."
    end
  end

  def create
    if current_user.try(:admin?)
      @job = Job.new(job_params)
      if @job.save
        flash[:success] = "You have successfully created a new package!"
        redirect_to :action => 'index'
      else
        render 'new'
      end
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def add_package
    if current_user.try(:admin?)
  	  @job = Job.find($current_id)
	    @package = Package.find_by_name(params[:package_name])
	    if @package.valid?
		    @job.packages << @package
	    end
	    redirect_to action:'show', id: $current_id
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def remove_package
    if current_user.try(:admin?)
      @job = Job.find($current_id)
      @package = Package.find(params[:id])
      @job.packages.destroy(@package)
      redirect_to action:'show', id: $current_id
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def edit
    if current_user.try(:admin?)
      @job= Job.find(params[:id])
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def update
    if current_user.try(:admin?)
      @job = Job.find(params[:id])
      if @job.update_attributes(job_params)
        flash[:success] = "The job has been successfully updated."
        redirect_to '/jobs/index'
      else
        render action: "edit"
      end
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def get_id
	  id = request.original_url.split(/\/(\d{1,})/)
    id.last
  end

  private

    def job_params
      params.require(:job).permit(:name, :description, :body, :deadline)
    end

end
