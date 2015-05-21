class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @patient = Patient.find(params[:patient_id])
    @relationship = @patient.relationships.build(relationship_params)
    if @relationship.save
      flash[:success] = "Parent added"
    else
      flash[:danger]  = "Unable to add parent"
    end
    redirect_to edit_patient_path(@patient)
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy
    flash[:success] = "Parent removed"
    redirect_to edit_patient_path(relationship.patient_id)
  end

  private

  def relationship_params
    params.require(:relationship).permit(:parent_id)
  end
end
