class SettingsController < ApplicationController
  before_action :logged_in_user

  def show
    @setting = Setting.instance
  end

  def update
    @setting = Setting.instance

    if @setting.update_attributes(setting_params)
      flash[:success] = 'Sucessfully saved settings'
      redirect_to root_url
    else
      render 'show'
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:title,
                                    :firstname,
                                    :lastname,
                                    :zip,
                                    :city,
                                    :street,
                                    :phonenumber,
                                    :email,
                                    :initial_invoicenumber)
  end


end
