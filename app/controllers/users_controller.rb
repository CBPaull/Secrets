class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  before_filter :skip_password_attribute, only: :update
  def index
  end

  def new
  end

  def create
    @user = User.create(user_params)
    if @user.errors.any?
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    else
      session[:user_id] = @user.id
      redirect_to "/users/#{session[:user_id]}"
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    @user.update(name: params[:name], email: params[:email])
    if @user.errors.any?
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    else
      session[:user_id] = @user.id
      redirect_to "/users/#{session[:user_id]}"
    end
  end

  def destroy
    User.destroy(session[:user_id])
    session.clear
    redirect_to session_new_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    def skip_password_attribute
    if params[:password].blank? && params[:password_validation].blank?
      params.except!(:password, :password_validation)
    end
  end
end
