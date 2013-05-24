# encoding: UTF-8

module BlogDashboard
  module Translatable
    extend ActiveSupport::Concern

    included do

      cattr_accessor :translatable_key
      cattr_accessor :slug_field

      if BlogDashboard::configuration.i18n_support &&
        translates_objec = BlogDashboard::configuration.translates[self.translatable_key]
        @@fields = translates_objec[:fields]
      end

      field :custom_slug, localize: @@fields.include?(:slug)
      slug self.slug_field, :custom_slug, history: true, localize: @@fields.include?(:slug), permanent: false do |doc|
        [doc.custom_slug, doc.send(self.slug_field)].reject(&:blank?).first.to_url
      end



      after_save :set_custom_slug

      def set_custom_slug
        if self.attributes['_slugs'][I18n.locale.to_s]
          custom_slug_attributes = self.attributes['custom_slug'].dup
          custom_slug_attributes[I18n.locale] = self.attributes['_slugs'][I18n.locale.to_s].last
          self.set('custom_slug', custom_slug_attributes)
        end
      end


      def self.translatable?
        keys = BlogDashboard::configuration.translates[self.translatable_key]
        BlogDashboard::configuration.i18n_support && keys.present? && keys.values.include?(true)
      end

      def self.translates_object
        BlogDashboard::configuration.translates[self.translatable_key]
      end

    end

    def translates_object
      self.class.translates_object
    end

    def translateds
      I18n.available_locales & self.translations.map(&:locale)
    end

    def translatable?(field)
      self.class.translatable? && translates_object[:fields] && translates_object[:fields].include?(field)
    end

    def check_translation_for(locale)
      relevant = translates_object[:relevant]
      if relevant && translates_object[:fields].include?(relevant) && self.attributes[relevant.to_s]
        self.attributes[relevant.to_s][locale.to_s]
      else
        # TODO
        # translation.present? ? '√' : 'X'
      end
    end

  end
end