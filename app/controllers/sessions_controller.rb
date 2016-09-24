class SessionsController < ApplicationController
  def new
    @login_page = true
    if logged_in?
      redirect_to patients_path
    end
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_back_or patients_path
    else
      flash.now[:danger] = 'Invalid username/password!'
      @login_page = true
      render 'new'
    end
  end

  def destroy
    log_out
    @login_page = true
    redirect_to root_url
  end

end
