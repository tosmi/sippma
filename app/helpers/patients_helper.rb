module PatientsHelper
  def have_patients?
    Patient.any?
  end
end
