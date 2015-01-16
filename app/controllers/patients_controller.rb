class PatientsController < ApplicationController

  def index
    if not Patient.any?
      render 'welcome'
    end
  end

  def show
  end

  def new
  end

end
