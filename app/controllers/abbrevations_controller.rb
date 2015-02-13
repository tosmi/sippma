class AbbrevationsController < ApplicationController
  before_action :logged_in_user

  def index
    template = 'index'

    @abbrevations = Abbrevation.all
    template = 'welcome' if @abbrevations.empty?
    respond_to do |format|
      format.html { render template}
      format.json { render json: @abbrevations }
    end
  end

  def new
    @abbrevation = Abbrevation.new
  end


  def create
    @abbrevation = Abbrevation.new(abbrevation_params)
    if @abbrevation.save
      flash[:success] = 'Successfully created new abbrevation.'
      redirect_to abbrevations_url
    else
      render 'new'
    end
  end

  def destroy
    Abbrevation.find(params[:id]).destroy
    flash[:success] = "Abbrevation deleted"
    redirect_to abbrevations_path
  end

  private

  def abbrevation_params
    params.require(:abbrevation).permit(:abbrev, :text)
  end

end
