require 'test_helper'

module BlogDashboard
  class PostsControllerTest < ActionController::TestCase

    def setup
      super
      mock_login
    end

    def create_post
      @post = Post.create(title: 'foo')
    end

    test "should get index" do
      get :index, use_route: :blog_dashboard
      assert_response :success
      assert_not_nil assigns(:posts)
    end

    test "should get new" do
      get :new, use_route: :blog_dashboard
      assert_response :success
      assert_not_nil assigns(:post)
      assert_equal assigns(:post).author, @current_user
      assert_template("new")
    end

    test "should redirect to edit if valid on create" do
      post :create, use_route: :blog_dashboard, post: {title: 'foo'}, button: Post::STATES[0]
      assert_redirected_to [:edit, assigns(:post)]
    end

    test "should render new if validations fails on create" do
      post :create, use_route: :blog_dashboard
      assert_response 200
      assert_template("new")
    end

    test "should get edit" do
      create_post
      get :edit, use_route: :blog_dashboard, id: @post.to_param
      assert_response :success
      assert_not_nil assigns(:post)
      assert_template("edit")
    end

    test "should redirect to edit if valid on update" do
      create_post
      put :update, use_route: :blog_dashboard, post: {title: 'foo'}, button: Post::STATES[0], id: @post.to_param
      assert_redirected_to [:edit, assigns(:post)]
    end

    test "should render edit if validations fails on update" do
      create_post
      put :update, use_route: :blog_dashboard, id: @post.to_param
      assert_response 200
      assert_template("edit")
    end

    test "should redirect to posts" do
      create_post
      delete :destroy, use_route: :blog_dashboard, id: @post.to_param
      assert_redirected_to [:posts]
    end

  end
end
