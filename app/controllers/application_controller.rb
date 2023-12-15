class ApplicationController < ActionController::Base
  helper_method :current_user

  def authenticate_user!
    unless current_user
      redirect_to login_path, notice: 'You need to log in to access that page!'
    end
  end

  def current_user
    @current_user ||=
      begin
        return nil unless session[:user_id]

        User.find(session[:user_id])
      end
  end
end
