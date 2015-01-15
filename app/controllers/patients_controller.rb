class PatientsController < ApplicationController
  include PatientsHelper

  def index
    if not have_patients?
      render 'no_patients'
    end
  end

  def show
  end

  def new
  end

end
