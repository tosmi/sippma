require 'test_helper'

class EntryLineTest < ActiveSupport::TestCase
  fixtures :patients, :entry_lines

  def setup
    @patient = patients(:max)
    @invoice = @patient.invoices.create(diagnosis: 'test',
                                       totalfee: 100,
                                       invoicenumber: '01-01-01-70',
                                       date: '01-01-1970',
                                       patient_id: @patient.id)
    @line    = @invoice.entry_lines.build(text: 'the first line',
                                          fee: 10.25)
  end

  test "saves a valid entryline" do
    assert @line.valid?
  end

  test "text should not be to long" do
    @line.text = "a" * 51
    assert_not @line.valid?
  end

  test "does not save an entry line if no corresponding invoice" do
    assert_raises ActiveRecord::RecordInvalid do
      EntryLine.create!(text: 'test',
                        fee: 10.25)
    end

  end
end
