require 'test_helper'

module BlogDashboard
  class PostTest < ActiveSupport::TestCase

    def setup
      @post = Post.new(title: 'a title')
    end

    test "should be valid" do
      assert @post.valid?
    end

    test "should require a title" do
      @post.title = nil
      assert @post.invalid?, 'should be invalid'
    end

    test "should have timestamps" do
      @post.save
      assert_not_nil @post.created_at
      assert_not_nil @post.updated_at
    end

    test "should accept Post::STATES for state" do
      Post::STATES.each do |state|
        @post.state = state
        assert @post.valid?, "should accept #{state} as state"
      end

      @post.state = 'foo'
      assert @post.invalid?, 'should not accept foo as state'
    end

    test "new post should be draft" do
      assert @post.draft?
    end

    test "states for draft" do
      @post.state = 'draft'
      assert @post.draft?
      assert !@post.published?
    end

    test "states for published" do
      @post.state = 'published'
      assert !@post.draft?
      assert @post.published?
    end

    test "should not set 'published_at' if not published" do
      @post.state = 'draft'
      @post.published_at_string = ''
      assert_nil @post.published_at
    end

    test "should set a valid DateTime if string is blank and is published" do
      @post.state = 'published'
      @post.published_at_string = ''
      assert_kind_of DateTime, @post.published_at, 'should be a DateTime'
    end

    test "should parse as valid DateTime the string if is published" do
      @post.state = 'published'
      @post.published_at_string = "2015/10/21 16:04:00"
      assert_equal Time.new(2015, 10, 21, 16, 04, 00), @post.published_at
    end

    test "should not raise I18n::ArgumentError" do
      date_time = DateTime.now
      @post.published_at = date_time
      assert_nothing_raised(I18n::ArgumentError){
        @post.published_at_string
      }
    end

    test "should return # if post_public_path_expresion is not setted" do
      BlogDashboard.configure do |config|
        config.post_public_path_expresion = nil
      end

      assert_equal @post.public_path, '#'
    end

    test "should replace :id from post_public_path_expresion" do
      BlogDashboard.configure do |config|
        config.post_public_path_expresion = '/blog/post/:id/show'
      end

      assert_equal @post.public_path, "/blog/post/#{@post.id}/show"
    end

    test "should set published_at on save if published and published_at is blank" do
      @post.state = 'published'
      @post.published_at = ''
      @post.title = "foo"
      @post.save
      assert_kind_of DateTime, @post.published_at
    end
  end
end
