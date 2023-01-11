class TasksController < ApplicationController
  # before_actionメソッド
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  #一覧画面
  def index
    #全てのタスクから所得する命令
    # @tasks = Task.order(id: "DESC")
    if params[:limit]
      @tasks = Task.sort_limit
    else
      @tasks = Task.all
    end
  end
  

  #詳細画面
  def show
  end

  #新規登録画面
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
  #編集画面
  def edit
  end
  #更新
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end
  #削除
  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end
  #確認
  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end



  private
  #StrongParameters
  def task_params
    params.require(:task).permit(:title, :content,:limit)
  end
  # idをキーとして値を取得するメソッドを追加
  def set_task
    @task = Task.find(params[:id])
  end



end
