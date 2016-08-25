class SessionController < ApplicationController
  def new
  end

  def login
  	@user = User.find_by email: params[:email]
  	flash[:errors] = []
  	unless @user 
  		flash[:errors].push 'Invalid email'
  		redirect_to :back
  	else 
      if @user.authenticate(params[:password])
      	session[:user_id] = @user.id
      	redirect_to "/users/#{session[:user_id]}"
      else
      	flash[:errors].push 'Invalid password'
      	redirect_to :back
      end
    end
  end

  def logout
  	session[:user_id] = false
  	redirect_to session_new_path
  end
end
