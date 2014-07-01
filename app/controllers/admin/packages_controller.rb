module Admin
class Admin::PackagesController < BaseController
  autocomplete :question, :name, :full => true

  def new
    @package = Package.new
  end

  def index
  	@packages = Package.paginate(page: params[:page])
  end

  def show
    @package = Package.find(params[:id])
    $current_id = get_id
  end

  def create
    @package = Package.new(package_params)
    if @package.save
      flash[:success] = "You have successfully created a new package!"
      redirect_to '/admin/packages/index'
    else
      render 'admin/new'
    end
  end

  def add
  	@package = Package.find($current_id)
	  @question = Question.find_by_name(params[:question_name])
	  if @question.valid?
		  @package.questions << @question
	  end
	  redirect_to action:'show', id: $current_id
  end

  def unpackage
    @package = Package.find($current_id)
    @question = Question.find(params[:id])
    @package.questions.destroy(@question)
    redirect_to action:'show', id: $current_id
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

end