require 'test_helper'

class EntryLineTest < ActiveSupport::TestCase
  fixtures :patients, :entry_lines

  def setup
    @patient = patients(:max)
    @invoice = @patient.invoices.build
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
end
