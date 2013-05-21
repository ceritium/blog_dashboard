require 'test_helper'

module BlogDashboard
  class ApplicationHelperTest < ActionView::TestCase

    class MainAppApplicationHelperBench
      def dummy_thing_path
        "/dummy_thing"
      end
      def dummy_thing_url
        "http://host/dummy_thing"
      end
      def secret
      end
    end

    class BlogDashboardApplicationHelperBench
      include BlogDashboard::ApplicationHelper

      def main_app
        MainAppApplicationHelperBench.new
      end
    end


    def raw_helper
      BlogDashboardApplicationHelperBench.new
    end

    test "should not know named routes of the main app if not configured" do
      BlogDashboard.configure {|c| c.inline_main_app_named_routes = false }
      assert_raise(NoMethodError){
        raw_helper.dummy_thing_path
      }

      assert_raise(NoMethodError){
        raw_helper.dummy_thing_url
      }
    end

    test "should know named routes of the main app" do
      BlogDashboard.configure {|c| c.inline_main_app_named_routes = true }
      assert_equal "/dummy_thing", raw_helper.dummy_thing_path
      assert_equal "http://host/dummy_thing", raw_helper.dummy_thing_url
    end

    test "should not know anything but named routes of the main app" do
      BlogDashboard.configure {|c| c.inline_main_app_named_routes = true }
      assert_raise(NoMethodError) { raw_helper.secret }
    end

    test "should not know other routes" do
      BlogDashboard.configure {|c| c.inline_main_app_named_routes = true }
      assert_raise(NoMethodError) { raw_helper.junk_path }
      assert_raise(NoMethodError) { raw_helper.junk_url }
    end

  end
end
