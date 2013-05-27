# encoding: UTF-8

module BlogDashboard
  module Translatable
    extend ActiveSupport::Concern

    included do
      class_eval do
        #####
        cattr_accessor :translatable_key
        cattr_accessor :slug_field

        def self.custom_fields
          translates_objec = BlogDashboard::configuration.translates[self.translatable_key]
          if BlogDashboard::configuration.i18n_support && translates_objec = BlogDashboard::configuration.translates[self.translatable_key]
            foo = translates_objec[:fields]
          end

          foo ||= []
        end

        field :custom_slug, localize: self.custom_fields.include?(:slug)
        slug self.slug_field, :custom_slug, history: true, localize: self.custom_fields.include?(:slug), permanent: false do |doc|
          [doc.custom_slug, doc.send(self.slug_field)].reject(&:blank?).first.to_url
        end

        before_save :set_custom_slug
        def set_custom_slug
          self.custom_slug = slug
        end


        def self.translatable?
          keys = BlogDashboard::configuration.translates[self.translatable_key]
          BlogDashboard::configuration.i18n_support && keys.present? && keys.values.include?(true)
        end

        def self.translates_object
          BlogDashboard::configuration.i18n_support ? BlogDashboard::configuration.translates[self.translatable_key] : {}
        end

        def translates_object
          self.class.translates_object
        end

        def translatable?(field)
          self.class.translatable? && translates_object[:fields] && translates_object[:fields].include?(field)
        end

        def check_translation_for(locale)
          relevant = translates_object[:relevant]
          if relevant && translates_object[:fields].include?(relevant) && self.attributes[relevant.to_s]
            self.attributes[relevant.to_s][locale.to_s]
          end
        end
      end
    end
  end
end