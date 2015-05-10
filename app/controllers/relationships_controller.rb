class RelationshipsController < ApplicationController

  def create
    @patient = Patient.find(params[:patient_id])
    @relationship = @patient.relationships.build(relationship_params)
    if @relationship.save
      flash[:success] = "Parent added"
      redirect_to 'patients/edit'
    else
      flash[:notice]  = "Unable to add parent"
      render 'patient/edit'
    end
  end

  def destroy
    @patient = Patient.find(params[:patient_id])
    @patient.relationships.find(params[:parent_id]).destroy
    flash[:success] = "Parent removed"
    render 'patients/edit'
  end

  private

  def relationship_params
    params.require(:relationship).permit(:parent_id)
  end
end
