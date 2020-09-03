module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = 'ログインしてください'
      redirect_to new_session_path
    end
  end
end
