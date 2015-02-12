class AbbrevationsController < ApplicationController

  def index
    if not Abbrevation.any?
      render 'welcome'
    end
    @abbrevations = Abbrevation.all
  end
end
