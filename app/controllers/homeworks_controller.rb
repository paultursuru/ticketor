class HomeworksController < ApplicationController
  before_action :redirect_to_root, except: [:new, :create]

  def index
    @homeworks = Homework.all
  end

  def new
    @homework = current_user.homeworks.new
  end

  def create
    @homework = current_user.homeworks.new(homework_params)
    if @homework.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Homework received ! 😉" }
        format.turbo_stream { flash.now[:notice] = "Homework received ! 😉" }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@homework, partial: "homeworks/form", locals: { homework: @homework }), status: :unprocessable_entity }
      end
    end
  end

  def edit
    @homework = Homework.find(params[:id])
  end

  def update
    @homework = Homework.find(params[:id])
  end

  def grade # method to grade homeworks
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
    @homeworks = Homework.all
    @graded = @homeworks.graded
    @students_with_no_homework = User.with_no_homework
    respond_to do |format|
      format.html
      format.csv { send_data @homeworks.to_csv, filename: "grades-#{Date.today}.csv" }
    end
  end

  def grade_zero
    @student = User.find(params[:student])

    @homework = Homework.new(user: @student, title: "no homework", url: "no url", grade: 0)
    if @homework.save
      redirect_to recap_homeworks_path, notice: "graded zero"
    end
  end

  private

  def redirect_to_root
    redirect_to root_path unless current_user.is_team?
  end

  def homework_params
    params.require(:homework).permit(:title, :url)
  end
end
