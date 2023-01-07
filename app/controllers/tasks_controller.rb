class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # 一覧画面
  def index
    @tasks = Task.all
  end

  #　詳細画面
  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスクを作成しました！"
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end



  private

  def task_params
    params.require(:task).permit(:title, :content,:limit)
  end

  def set_task
    @task = Task.find(params[:id])
  end



end
