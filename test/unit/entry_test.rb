require 'test_helper'

class EntryTest < ActiveSupport::TestCase

  def test_empty_status_and_location_id
    entry = Entry.new()
    
    assert !entry.valid?
    assert entry.errors.invalid?(:status_id)
    assert entry.errors.invalid?(:location_id)
  end
end
