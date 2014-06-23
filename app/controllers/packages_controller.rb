class PackagesController < ApplicationController
  autocomplete :question, :name, :full => true
  $current_id = 0
  def new
    if current_user.try(:admin?)
      @package = Package.new
    else
      flash[:error] = "You do not have right to access this function."
      render :action => 'index'
    end
  end

  def index
  	@packages = Package.paginate(page: params[:page])
  end

  def show
    @package = Package.find(params[:id])
    $current_id = get_id
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
      flash[:error] = "You do not have right to access this function."
      render :action => 'index'
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
      flash[:error] = "You do not have right to access this function."
    end
  end

  def unpackage
    if current_user.try(:admin?)
      @package = Package.find($current_id)
      @question = Question.find(params[:id])
      @package.questions.destroy(@question)
      redirect_to action:'show', id: $current_id
    else
      flash[:error] = "You do not have right to access this function."
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
