class Admin::UsersController < ApplicationController
  before_action :set_user, only:  [:show, :edit, :update, :destroy]
  before_action :not_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path,notice: User.human_attribute_name(:user_created)
    else
      render :new
    end
  end

  def show
    @tasks = current_user.tasks
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path,notice: User.human_attribute_name(:user_updated)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: User.human_attribute_name(:user_deleted)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation,:admin)
  end

  def not_admin
    unless current_user.admin?
      redirect_to tasks_path
      flash[:notice] = "管理者以外はアクセスできません"
    end
  end


end
