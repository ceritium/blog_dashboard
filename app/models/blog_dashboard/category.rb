module BlogDashboard
  class Category
    include Mongoid::Document
    include Mongoid::Timestamps

    def self.translatable_key
      :post
    end

    include BlogDashboard::Translatable



    field :name, type: String
    validates :name, presence: true

    has_and_belongs_to_many :posts, class_name: "BlogDashboard::Post"

    default_scope order_by('name desc')

    def to_s
      name
    end

  end
end
