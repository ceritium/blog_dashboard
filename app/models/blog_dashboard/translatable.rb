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

      if translatable?
        include Mongoid::Globalize
        translates_object = self.translates_object
        translates do
          if translates_object[:fields]
            translates_object[:fields].each do |element|
              field element
            end
          end
          fallbacks_for_empty_translations! if translates_object[:fallbacks_for_empty_translations]
        end
      end
    end


    def translates_object
      self.class.translates_object
    end

    def translateds
      I18n.available_locales & self.translations.map(&:locale)
    end

    def translatable?(field)
      self.class.translatable? && translates_object[field]
    end

    def check_translation_for(locale)
      translation = translations.select{|x| locale.to_s == x.locale.to_s }[0]
      if translates_object[:relevant]
        translation.try(translates_object[:relevant])
      else
        translation.present? ? '√' : 'X'
      end
    end

  end
end