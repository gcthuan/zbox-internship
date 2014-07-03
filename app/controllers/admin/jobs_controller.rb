module Admin

class Admin::JobsController < BaseController
  autocomplete :package, :name, :full => true

  def new
    @job = Job.new
  end

  def index
  	@jobs = Job.paginate(page: params[:page])
  end

  def show
    @job = Job.find(params[:id])
    $current_id = get_id
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      flash[:success] = "You have successfully created a new package!"
      redirect_to :action => 'index'
    else
      render 'new'
    end
  end

  def add_package
  	@job = Job.find($current_id)
	  @package = Package.find_by_name(params[:package_name])
	  if @package.valid?
		  @job.packages << @package
	  end
	  redirect_to action:'show', id: $current_id
  end

  def remove_package
    @job = Job.find($current_id)
    @package = Package.find(params[:id])
    @job.packages.destroy(@package)
    redirect_to action:'show', id: $current_id
  end

  def tag
    if params[:tag].present?
      @jobs = Job.tagged_with(params[:tag]).paginate(:per_page => 30, :page => params[:page])
    else 
      @jobs = Job.paginate(page: params[:page])
    end
  end

  def edit
    @job= Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      flash[:success] = "The job has been successfully updated."
      redirect_to '/admin/jobs/index'
    else
      render action: "edit"
    end
  end

  def get_id
	  id = request.original_url.split(/\/(\d{1,})/)
    id.last
  end

  private

    def job_params
      params.require(:job).permit(:name, :description, :body, :deadline, :tag_list)
    end

end

end