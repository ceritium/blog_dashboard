# encoding: UTF-8

module BlogDashboard
  module Translatable
    extend ActiveSupport::Concern

    included do

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
        # translation.present? ? '√' : 'X'
      end
    end

  end
end