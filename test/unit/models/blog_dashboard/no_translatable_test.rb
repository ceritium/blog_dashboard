require 'test_helper'

module BlogDashboard
  class NoTranslatableTest < ActiveSupport::TestCase


    class NoTranslatableDummy
      include Mongoid::Document
      include Mongoid::Slug
      @@translatable_key = :post
      @@slug_field = :title

      field :title, type: String, localize: false
      include BlogDashboard::Translatable

    end

    def setup
      i18n_support_false
      @dummy = NoTranslatableDummy.new(title: "title")
    end

    test "shoud no have title_translations" do
      assert !@dummy.respond_to?(:title_translations)
    end

    test "should save" do
      assert @dummy.save
    end

    test "should set custom_slug" do
      @dummy.save
      assert_kind_of String, @dummy.custom_slug
    end

    test "should slugize the custom slug" do
      @dummy.custom_slug = "a title"
      @dummy.save
      assert_equal @dummy.custom_slug, 'a-title'
    end

    test "self.translatable? should be false" do
      assert !NoTranslatableDummy.translatable?
    end

    test "self.translates_object should return a empty hash" do
      assert_equal NoTranslatableDummy.translates_object, {}

      BlogDashboard.configure do |config|
        config.translates = { post: { foo: :bar } }
      end

      assert_equal NoTranslatableDummy.translates_object, {}

    end

    test "translates_object should return the same that self.translates_object" do
      assert_equal @dummy.translates_object, NoTranslatableDummy.translates_object
      assert_equal @dummy.translates_object, {}
    end

    test "translatable? should be false" do
      assert !@dummy.translatable?(:title)
      assert !@dummy.translatable?(:foo)
    end

    test "check_translation_for return the relevant_field if exists for the locale" do
      assert @dummy.check_translation_for('en').blank?
      assert @dummy.check_translation_for('es').blank?
    end


  end
end