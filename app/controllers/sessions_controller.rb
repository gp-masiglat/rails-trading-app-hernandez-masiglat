class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Login successful!'
    else
      # flash.now[:notice] = 'Invalid username or password'
      redirect_to login_path, notice: 'Invalid username or password'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Logged out successfully!'
  end
end
