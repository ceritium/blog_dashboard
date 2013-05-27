require 'test_helper'

class BlogDashboardTest < ActiveSupport::TestCase

  test "should allow developers to set configurations with a block" do
    initial_value = BlogDashboard.configuration.layout
    BlogDashboard.configure do |config|
      config.layout = "custom_layout_developer"
    end
    user_set_value = BlogDashboard.configuration.inline_main_app_named_routes
    assert_not_equal initial_value, user_set_value
  end

  def teardown
    BlogDashboard.configure do |config|
      config.inspect
    end
  end


end
