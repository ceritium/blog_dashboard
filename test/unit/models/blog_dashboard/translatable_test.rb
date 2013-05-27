require 'test_helper'

module BlogDashboard
  class TranslatableTest < ActiveSupport::TestCase



    class TranslatableDummy
      include Mongoid::Document
      include Mongoid::Slug
      @@translatable_key = :post
      @@slug_field = :title

      field :title, type: String, localize: true
      include BlogDashboard::Translatable

    end

    def setup
      i18n_support_true
      @dummy = TranslatableDummy.new(title: "title")
    end

    def teardown
      i18n_support_false
    end

    test "shoud have title_translations" do
      assert @dummy.title_translations.present?
    end

    test "should save" do
      assert @dummy.save
    end

    test "should set custom_slug" do
      @dummy.save
      assert @dummy.custom_slug.present?
      assert_kind_of String, @dummy.custom_slug
    end

    test "should slugize the custom slug" do
      @dummy.custom_slug = "a title"
      @dummy.save
      assert_equal @dummy.custom_slug, 'a-title'
    end

    test "self.translatable? should be true" do
      assert TranslatableDummy.translatable?
    end

    test "self.translates_object should return the hash config for the translatable_key" do
      assert_equal TranslatableDummy.translates_object, {
        fields: [:title, :body, :slug],
        fallbacks_for_empty_translations: true,
        relevant: :title
      }

      BlogDashboard.configure do |config|
        config.translates = { post: { foo: :bar } }
      end

      assert_equal TranslatableDummy.translates_object, {foo: :bar}

    end

    test "translates_object should return the same that self.translates_object" do
      assert_equal @dummy.translates_object, TranslatableDummy.translates_object
    end

    test "translatable? should be true if the model is translatable and the field" do
      assert @dummy.translatable?(:title)
      assert !@dummy.translatable?(:foo)
    end

    test "check_translation_for return the relevant_field if exists for the locale" do
      assert_equal @dummy.check_translation_for('en'), 'title'
      assert @dummy.check_translation_for('es').blank?
    end
  end
end