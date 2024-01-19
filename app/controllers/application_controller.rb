class ApplicationController < ActionController::Base
  helper_method :current_user, :approved_user

  def authenticate_user!
    unless current_user
      redirect_to login_path, notice: 'You need to log in to access that page!'
    end
  end

  def authorize_user!
    unless current_user.status == 'Approved'
      redirect_to root_path, notice: 'Your account needs to be approved to access that page!'
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
