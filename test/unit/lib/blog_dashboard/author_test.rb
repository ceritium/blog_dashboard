require 'test_helper'

module BlogDashboard

  class AuthorTest < ActiveSupport::TestCase

    class DummyUser
      include Mongoid::Document
      include BlogDashboard::Author

      def to_s
        "dummy user"
      end
    end


    def setup
      @dummy_user = DummyUser.new
    end

    test "should add has_many posts" do
      assert_equal Mongoid::Relations::Targets::Enumerable, @dummy_user.posts.class
      assert_kind_of BlogDashboard::Post, @dummy_user.posts.new
    end

    test "post should acdept DummyUser as a author" do
      @post = Post.new(title: 'foo')
      @dummy_user.save

      @post.author = @dummy_user
      @post.save
      @post.reload

      assert_kind_of DummyUser, @post.author
      assert_equal @post.author, @dummy_user
    end

  end
end