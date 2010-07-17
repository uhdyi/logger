require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  def setup
    @lbd = products(:lbd)
  end

  def test_with_empty_part_number
    product = Product.new

    assert !product.valid?
    assert product.errors.invalid?(:part_number)
  end

  def test_uniqueness_of_part_number
    product = Product.new(:part_number => @lbd.part_number)
    
    assert !product.save
    assert_equal "has already been taken", product.errors.on(:part_number)
  end
end
