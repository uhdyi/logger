require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @dan = users(:dan)
  end

  def test_with_empty_name
    user = User.new

    assert !user.valid?
    assert user.errors.invalid?(:name)
  end

  def test_uniqueness_of_name
    user = User.new(:name => @dan.name)

    assert !user.save
    assert_equal "has already been taken", user.errors.on(:name)
  end
end
