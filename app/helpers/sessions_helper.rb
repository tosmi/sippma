module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    # - find_by simply returns nil (find raises) if no user id found
    # - cache the current user in an instanced variable so we do not hit
    #   the database on every call to curren_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

end
