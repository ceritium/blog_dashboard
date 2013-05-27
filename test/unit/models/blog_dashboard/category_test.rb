require 'test_helper'

module BlogDashboard
  class CategoryTest < ActiveSupport::TestCase


    def setup
      i18n_support_false
      @category = Category.new(name: 'foo')
    end

    test "should be valid" do
      assert @category.valid?
    end

    test "should require a name" do
      @category.name = nil
      assert @category.invalid?
    end

    test "to_s should be name" do
      assert_equal @category.name, @category.to_s
    end

    test "should have timestamps" do
      @category.save
      assert_not_nil @category.created_at
      assert_not_nil @category.updated_at
    end
  end
end
