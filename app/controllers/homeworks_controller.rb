class HomeworksController < ApplicationController
  def index
    redirect_to root_path if current_user.student?
    @homeworks = Homework.all
  end

  def new
    @homework = Homework.new
  end

  def create
    @homework = Homework.new(homework_params)
    @homework.user = current_user
    if @homework.save
      redirect_to homeworks_path
      flash[:notice] = "Thank you for your homework ✔️"
    else
      render :new, status: :unprocessable_entity
      flash[:alert] = "Woupsy something went wrong 😬"
    end
  end

  def edit
    @homework = Homework.find(params[:id])
  end

  def update
    @homework = Homework.find(params[:id])
  end

  def grade
    redirect_to root_path unless current_user.teacher?
    @homeworks = Homework.all
    @homework = Homework.find(params[:id])
    if params[:grade] == "nil"
      @homework.update_attribute(:grade, nil)
    else
      @homework.update_attribute(:grade, params[:grade])
    end
    respond_to do |format|
      format.json { render json: @homework }
    end
  end

  private

  def homework_params
    params.require(:homework).permit(:title, :url)
  end
end
