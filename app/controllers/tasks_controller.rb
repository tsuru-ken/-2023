class TasksController < ApplicationController
  # before_actionメソッド
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  #一覧画面
  def index
    @tasks =Task.all

    # 終了期限/優先度ソート機能
    if params[:sort_limit]
      @tasks = @tasks.sort_limit
    elsif [:sort_priority]
      @tasks = @tasks.sort_priority
    end

    if params[:search].present?
      @tasks = @tasks
        .search_status(params[:search][:status])
        .search_title(params[:search][:title])
        # .search_label(params[:search][:label_id])
    end
      # ページネーション
      @tasks = Task.order(created_at: :desc).page(params[:page])

  #モデル記載
  # /if params[:search].present?
        #  if params[:search][:status].present? && params[:search][:title].present?
          #  @tasks = @tasks.search_status(params[:search][:status]).search_title(params[:search][:title])
        #  elsif params[:search][:status].present?
          # @tasks = @tasks.search_status(params[:search][:status])
        #  elsif params[:search][:title].present?
          #  @tasks = @tasks.search_title(params[:search][:title])
        #  end
      #  end
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
    @task = Task.new(task_params)
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



end
