require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter "/test/"
  add_filter "/config/"
end

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

require 'capybara/rails'

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

require 'database_cleaner'


def i18n_support_false
  BlogDashboard.configure do |config|
    config.i18n_support = false
  end
end

def i18n_support_true
  BlogDashboard.configure do |config|
    config.i18n_support = true
    config.translates = {
      post: {
        fields: [:title, :body, :slug],
        fallbacks_for_empty_translations: true,
        relevant: :title
      },
      category: {
        fields: [:name, :slug],
        relevant: :name,
        fallbacks_for_empty_translations: true
      }

    }
  end

end

class ActiveSupport::TestCase


  def setup
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean!

  end
end

class ActionController::TestCase
  include BlogDashboard::Engine.routes.url_helpers
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end
