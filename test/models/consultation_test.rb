require 'test_helper'

class ConsultationTest < ActiveSupport::TestCase

  def setup
    @patient = Patient.create!(firstname: 'Max',
                           lastname: 'Mustermann',
                           email: 'max@mustermann.at',
                           birthdate: Date.today,
                           zip: '1234',
                           city: 'Gotham',
                           street: 'Teststreet 3/8',
                           phonenumber1: '0664/123456',
                           phonenumber2: '0676-123456',
                           ssn: '1234',
                           insurance: 'GG')
    @consultation = @patient.consultations.create!(content: 'The First', diagnosis: 'The Diagnosis')
  end

  test "consultation should be valid" do
    assert @consultation.valid?
  end

  test "patient id should be present" do
    @consultation.patient_id = nil
    assert_not @consultation.valid?
  end

  test "diagnosis should be present" do
    @consultation.diagnosis = nil
    assert_not @consultation.valid?
  end

  test "diagnosis should not be too long" do
    @consultation.diagnosis = "a" * 201
    assert_not @consultation.valid?
  end

  test "consultations should be most recent first" do
    @consultation2 = @patient.consultations.build(content: 'The Second', diagnosis: 'The Diagnosis')
    @consultation2.created_at = Date.yesterday
    @consultation2.save
    assert_equal Consultation.first, @consultation
  end

end
