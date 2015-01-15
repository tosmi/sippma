class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to patients_path
    end
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to patients_path
    else
      flash.now[:danger] = 'Invalid username/password!'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
