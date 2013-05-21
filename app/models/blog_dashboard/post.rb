module BlogDashboard
  class Post
    include Mongoid::Document
    include Mongoid::Timestamps

    STATES = ['draft', 'published']

    field :title, type: String
    field :body, type: String
    field :published_at, type: DateTime
    field :state, type: String, default: STATES[0]

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
