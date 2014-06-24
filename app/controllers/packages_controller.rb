class PackagesController < ApplicationController
  autocomplete :question, :name, :full => true
  $current_id = 0
  def new
    if current_user.try(:admin?)
      @package = Package.new
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def index
    if current_user.try(:admin?)
  	  @packages = Package.paginate(page: params[:page])
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def show
    if auth_check
      @package = Package.find(params[:id])
      $current_id = get_id
    else
      flash[:alert] = "You need to sign in or sign up before continue."
    end
  end

  def create
    if current_user.try(:admin?)
      @package = Package.new(package_params)
      if @package.save
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

  def add
    if current_user.try(:admin?)
  	  @package = Package.find($current_id)
	    @question = Question.find_by_name(params[:question_name])
	    if @question.valid?
		    @package.questions << @question
	    end
	    redirect_to action:'show', id: $current_id
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def unpackage
    if current_user.try(:admin?)
      @package = Package.find($current_id)
      @question = Question.find(params[:id])
      @package.questions.destroy(@question)
      redirect_to action:'show', id: $current_id
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def delete
	
  end

  def get_id
	  id = request.original_url.split(/\/(\d{1,})/)
    id.last
  end

  private

    def package_params
      params.require(:package).permit(:name)
    end


end
