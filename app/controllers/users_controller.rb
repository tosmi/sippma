class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User successfully created'
      redirect_to users_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'User sucessfully updated'
      redirect_to users_url
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.username == 'admin'
      flash[:danger] = 'You cannot delete the admin user'
      redirect_to users_url
    else
      user.destroy
      flash[:success] = 'User deleted'
      redirect_to users_url
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :fullname,
      :email,
      :password,
      :password_confirmation,
      )
  end
end
