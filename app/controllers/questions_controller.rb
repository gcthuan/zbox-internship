class QuestionsController < ApplicationController

  def new
    if current_user.try(:admin?)
  	  @question = Question.new
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def index
    if current_user.try(:admin?)
  	  @questions = Question.paginate(page: params[:page])
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def show
    if auth_check
      @question = Question.find(params[:id])
    else
      flash[:notice] = "You need to sign in or sign up before continue."
    end
  end

  def create
    if current_user.try(:admin?)
	    @question = Question.new(question_params)
      if @question.save
        flash[:success] = "The question has been successfully created."
        redirect_to '/questions/index'
      else
        render action: "new"
      end
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def edit
    if current_user.try(:admin?)
      @question= Question.find(params[:id])
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
    end
  end

  def update
    if current_user.try(:admin?)
      @question = Question.find(params[:id])
      if @question.update_attributes(question_params)
        flash[:success] = "The question has been successfully updated."
        redirect_to '/questions/index'
      else
        render action: "edit"
      end
    else
      flash[:alert] = "You do not have right to access this function."
      redirect_to root_path
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
