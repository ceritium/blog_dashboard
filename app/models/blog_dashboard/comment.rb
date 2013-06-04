module BlogDashboard
  class Comment
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, type: String
    field :email, type: String
    field :body, type: String
    field :website, type: String
    field :state, type: String, default: 'approved'
    belongs_to :post, class_name: "BlogDashboard::Post"

    STATES = ['approved', 'pending', 'spam', 'trashed']

    # TODO: Check if this is optimal
    URL_REGEX   = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix

    # TODO: Check if this is optimal
    EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

    before_validation :format_website
    scope :approved, where(state: 'approved')

    validates :name, presence: true
    validates :email, presence: true, format: {with: EMAIL_REGEX, allow_blank: true }
    validates :body, presence: true, length: { minimum: 4, allow_blank: true}
    validates :website, format: {with: URL_REGEX, allow_blank: true}

    private

      # Prepend http to the url before the validation check
      def format_website
        if self.website.present? and self.website !~ /^http/i
          self.website = "http://#{self.website}"
        end
      end


  end
end
