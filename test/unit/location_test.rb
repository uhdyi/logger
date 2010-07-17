require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  fixtures :locations

  def setup
    @hoana = locations(:hoana)
  end

  def test_uniqueness_of_detail
    hoana_dup = Location.new(:detail => @hoana.detail)

    assert !hoana_dup.save
    assert_equal "has already been taken", hoana_dup.errors.on(:detail)
  end

  def test_name_with_detail
    assert_equal('hoana/hoana', @hoana.name_with_detail)
  end

end
