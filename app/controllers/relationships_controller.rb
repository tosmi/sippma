class RelationshipsController < ApplicationController

  def create
    @patient = Patient.find(params[:patient_id])
    @relationship = @patient.relationships.build(relationship_params)
    if @relationship.save
      flash[:success] = "Parent added"
    else
      flash[:notice]  = "Unable to add parent"
    end
    redirect_to 'patients/edit'
  end

  def destroy
    @patient = Patient.find(params[:patient_id])
    @relationship = @patient.relationships.find(params[:parent_id]).destroy
    flash[:success] = "Parent removed"
    render 'patients/edit'
  end

  private

  def relationship_params
    params.require(:relationship).permit(:parent_id)
  end
end
