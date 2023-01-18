class TasksController < ApplicationController
  # before_actionメソッド
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  skip_before_action :login_required, only: [:new, :create]
  # skip_before_action :logout_required
  before_action :correct_user, only: [:show, :edit]

  #一覧画面
  def index

    @tasks = current_user.tasks


    if params[:sort_limit]
      @tasks = @tasks.sort_limit
    elsif [:sort_priority]
      @tasks = @tasks.sort_priority
    end

    if params[:search].present?
      @tasks = @tasks
        .search_status(params[:search][:status])
        .search_title(params[:search][:title])
    end
    @tasks = @tasks.page(params[:page])
  end



  #詳細画面
  def show
  end

  #新規登録画面
  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスクを作成したわよ💖！"
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
      redirect_to tasks_path, notice: "タスクを編集したわよ💖！"
    else
      render :edit
    end
  end
  #削除
  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しましたわよ💔！"
  end
  #確認
  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end



  private
  #StrongParameters
  def task_params
    params.require(:task).permit(:title, :content, :limit, :status, :priority, :label_ids)
  end
  # idをキーとして値を取得するメソッドを追加
  def set_task
    @task = Task.find(params[:id])
  end

  def correct_user
    user_id = Task.find(params[:id]).user_id
    redirect_to tasks_path, notice: User.human_attribute_name(:correct_user)
    unless current_user?(user_id)
    end
  end
end
