class Admin::UsersController < ApplicationController
  before_action :set_user, only:  [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path
    else
      render :new
    end
  end

  def show
    @tasks = current_user.tasks
  end

  def edit
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

  private
  def set_user
    @user = User.find(params[:id])
    unless @user
      flash[:alert] = "User not found."
      redirect_to admin_users_path and return
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:admin)
  end


end
