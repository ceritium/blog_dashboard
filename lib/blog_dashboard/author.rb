module BlogDashboard
  module Author
    extend ActiveSupport::Concern

    included do
      has_many :posts, :as => "author", :class_name => "BlogDashboard::Post"
    end

  end
end