class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  def index
  	unless session[:user_id]
  		redirect_to session_new_path
  	end
  	@secrets = Secret.all.order('updated_at DESC')
  end

  def new
  end

  def create
  	@secret = Secret.create(secret_params)
    if @secret.errors.any?
      flash[:errors] = @secret.errors.full_messages
      redirect_to :back
    else
      redirect_to "/users/#{session[:user_id]}"
    end
  end

  def destroy
  	secret = Secret.find(params[:id])
    secret.destroy if secret.user == current_user
    redirect_to "/users/#{current_user.id}"
  end
  private
  	def secret_params
  	  params.require(:secret).permit(:content, :user_id)
  	end
end
