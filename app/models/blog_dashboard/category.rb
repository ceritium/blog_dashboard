module BlogDashboard
  class Category
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Slug

    if BlogDashboard::configuration.i18n_support &&
      translates_category = BlogDashboard::configuration.translates[:category]
      fields = translates_category[:fields]
    end

    def self.translatable_key
      :category
    end

    include BlogDashboard::Translatable

    field :name, type: String, localize: fields.include?(:name)
    slug :name, localize: fields.include?(:slug)

    validates :name, presence: true
    has_and_belongs_to_many :posts, class_name: "BlogDashboard::Post"

    default_scope order_by('name desc')

    def to_s
      name
    end

  end
end
