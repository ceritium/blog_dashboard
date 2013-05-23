require 'jquery-rails'
require 'mongoid'
require 'mongoid_globalize'
require "haml-rails"
require "twitter-bootstrap-rails"
require 'formtastic'
require 'formtastic-bootstrap'
require 'kaminari'
require "carrierwave"
require "carrierwave/mongoid"

require 'redactor-rails'
require "mini_magick"

require "blog_dashboard/engine"
require "blog_dashboard/configuration"
require "blog_dashboard/author"

module BlogDashboard
  # Exception raised when gem may not be configured properly
  class ConfigurationError < StandardError;end

  # Set global configuration options for I18nDashboard
  # @see README.md
  def self.configure(&block)
    block.call(configuration)
  end

  # Returns I18nDashboard's globalconfiguration. Will initialize a new instance
  # if not already set
  def self.configuration
    @configuration ||= Configuration.new
  end

end
