class UsersController < ApplicationController
  # before_action :set_user, only: [ :show, :edit, :update ]
  # before_action :correct_user, only: [ :show]
  skip_before_action :login_required, only: [:new, :create]
  # skip_before_action :logout_required, except: [:new, :create]


  def new
    if current_user
      redirect_to tasks_path, notice: "すでにログインしているわよ💖！"
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to tasks_path, notice: User.human_attribute_name(:account_update)
    else
      render :new
    end
  end

  def show
    set_user
    if current_user.id != @user.id
      redirect_to tasks_path, notice: "このページを表示する権限がありませんよ💖！"
    end
  end


  def edit
    set_user
  end

  def update
    set_user
    if @user = User.find(params)
      redirect_to user_path(@user.id), notice: User.human_attribute_name(:account_update)
    else
      render :edit
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:admin)
  end

  # def correct_user
  #   user_id = User.find(params[:id]).id
  #   redirect_to tasks_path, notice: User.human_attribute_name(:correct_user) unless correct_user?(user_id)
  # end
end