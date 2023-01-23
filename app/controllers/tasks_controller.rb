class TasksController < ApplicationController
  # before_actionメソッド
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  skip_before_action :login_required, only: [:new, :create]
  # skip_before_action :logout_required
  # before_action :correct_user, only: [:show, :edit]

  #一覧画面
  def index

    @tasks = current_user.tasks
    # @labels = Label.all


    # 終了期限とソート機能
    if params[:sort_limit]
      @tasks = @tasks.sort_limit
    elsif [:sort_priority]
      @tasks = @tasks.sort_priority
    end
    # 検索
    if params[:search].present?
      @tasks = @tasks
        .search_status(params[:search][:status])
        .search_title(params[:search][:title])
        .search_label(params[:search][:label_id])
    end

    # ページネーション
    @tasks = @tasks.page(params[:page])
  end



  #詳細画面
  def show
    # @labels = Label.all
  end

  #新規登録画面
  def new
    @task = Task.new
    # ラベルの一覧を取得してインスタンス変数に格納
    # @labels = Label.all
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id

    if params[:task][:label_ids].present?
    @task.labels << Label.find(params[:task][:label_ids])
    end
    # if params[:back]
    #   render :new
    # else
    # ラベルをタスクに紐付けするコード
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成したわよ💖！"
    else
      render :new
    end
  end
  #編集画面
  def edit
    # @labels = Label.all
  end
  #更新
  def update
    # ラベルをタスクに紐付けするコード
    if params[:task][:label_ids].present?
      @task.labels = Label.find(params[:task][:label_ids])
    end
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを更新したわよ💖！"
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
    @labels = Label.all
    render :new if @task.invalid?
  end



  private
  #StrongParameters
  def task_params
    params.require(:task).permit(:title, :content, :limit, :status, :priority, label_ids: [] )
  end
  # idをキーとして値を取得するメソッドを追加
  def set_task
    @task = Task.find(params[:id])
  end

  # def correct_user
  #   user_id = Task.find(params[:id]).user_id
  #   redirect_to tasks_path, notice: User.human_attribute_name(:correct_user)
  #   unless current_user?(user_id)
  #   end
  # end
end
