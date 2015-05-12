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
    Relationship.find(params[:id]).destroy
    flash[:success] = "Parent removed"
    redirect_to 'patients/edit'
  end

  private

  def relationship_params
    params.require(:relationship).permit(:parent_id)
  end
end
