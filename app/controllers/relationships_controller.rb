class RelationshipsController < ApplicationController

  def create
    @patient = Patient.find(params[:patient_id])
    @relationship = @patient.relationships.build(relationship_params)
    if @relationship.save
      flash[:success] = "Parent added"
    else
      flash[:notice]  = "Unable to add parent"
    end

    @patient.reload

    respond_to do |format|
      format.html { render partial: 'patients/parent',
                           layout: false,
                           collection: @patient.relationships,
                           as: 'relationship'
      }
      format.js
    end
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
