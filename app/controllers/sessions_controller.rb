class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      render :inline =>  '<h1>logged in</h1>'
    else
      render 'new'
    end
  end

  def destroy
  end
end
