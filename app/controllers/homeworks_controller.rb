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
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Homework received ! 😉" }
        format.turbo_stream { flash.now[:notice] = "Homework received ! 😉" }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity, alert: "Woupsy something went wrong 😬" }
        format.turbo_stream { flash.now[:alert] = "Woupsy something went wrong 😬"}
      end
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

  def student_recap
    redirect_to root_path unless current_user.teacher?
    @homeworks = Homework.all
    @graded = @homeworks.graded
    respond_to do |format|
      format.html
      format.csv { send_data @homeworks.to_csv, filename: "grades-#{Date.today}.csv" }
    end
  end

  private

  def homework_params
    params.require(:homework).permit(:title, :url)
  end
end
