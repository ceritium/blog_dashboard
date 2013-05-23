module BlogDashboard
  class Post
    include Mongoid::Document
    include Mongoid::Timestamps


    STATES = ['draft', 'published']

    field :title, type: String
    field :body, type: String
    field :published_at, type: DateTime
    field :state, type: String, default: STATES[0]


    def self.translatable?
      BlogDashboard::configuration.i18n_support && BlogDashboard::configuration.translates[:post].values.include?(true)
    end

    if translatable?
      def self.translates_post
        BlogDashboard::configuration.translates[:post]
      end

      def translates_post
        Post.translates_post
      end

      include Mongoid::Globalize
      translates_post = Post.translates_post
      translates do
        field :title                      if translates_post[:title]
        field :body                       if translates_post[:body]
        field :published_at               if translates_post[:published_at]
        field :state                      if translates_post[:state]
        fallbacks_for_empty_translations! if translates_post[:fallbacks_for_empty_translations]
      end

      def check_translation_for(locale)

        translation = translations.select{|x| locale.to_s == x.locale.to_s }[0]
        if translates_post[:relevant]
          translation.try(translates_post[:relevant])
        else
          translation.present? ? '√' : 'X'
        end
      end

    end


    has_and_belongs_to_many :categories, class_name: "BlogDashboard::Category"
    belongs_to :author, polymorphic: true


    has_many :comments, class_name: "BlogDashboard::Comment"


    validates :title, presence: true
    validates :state, inclusion: { in: STATES }

    after_save :set_published_at


    def draft?
      state == 'draft'
    end

    def published?
      state == 'published'
    end

    def published_at_string=(string)
      if self.published?
        self.published_at = string.blank? ? DateTime.now : DateTime.strptime(string, '%Y/%m/%d %H:%M:%S')
      end
    end

    def published_at_string
      I18n.l(published_at, format: '%Y/%m/%d %H:%M:%S') if published_at
    end

    def public_path
      if BlogDashboard::configuration.post_public_path_expresion
        BlogDashboard::configuration.post_public_path_expresion.gsub(":id", id)
      else
        "#"
      end
    end

    private

    def set_published_at
      if published? && published_at.blank?
        self.set(:published_at, Time.now.utc)
      end
    end
  end
end
