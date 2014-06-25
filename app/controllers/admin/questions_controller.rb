module Admin

class Admin::QuestionsController < BaseController

  def new
  	@question = Question.new
  end

  def index
  	 @questions = Question.paginate(page: params[:page])
  end

  def show
    @question = Question.find(params[:id])
  end

  def create
	  @question = Question.new(question_params)
    if @question.save
      flash[:success] = "The question has been successfully created."
      redirect_to '/admin/questions/index'
    else
      render action: "new"
    end

  end

  def edit
    @question= Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      flash[:success] = "The question has been successfully updated."
      redirect_to '/admin/questions/index'
    else
      render action: "edit"
    end
  end

  def tag
    if params[:tag].present?
      @questions = Question.tagged_with(params[:tag]).paginate(:per_page => 30, :page => params[:page])
    else 
      @questions = Question.paginate(page: params[:page])
  end
  end

  private

    def question_params
	    params.require(:question).permit(:name, :description, :body, :difficulty, :tag_list)
    end
  
end

end