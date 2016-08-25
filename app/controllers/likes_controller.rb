class LikesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  def create
  	@like = Like.create(like_params)
    if @like.errors.any?
      flash[:errors] = @like.errors.full_messages
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
  	like = Like.find(params[:id])
    if like.user == current_user
      like.destroy 
      redirect_to :back
    else
      redirect_to "/users/#{session[:user_id]}"
    end
  end
  private
  	def like_params
  	  params.require(:like).permit(:user_id, :secret_id)
 	end
end
