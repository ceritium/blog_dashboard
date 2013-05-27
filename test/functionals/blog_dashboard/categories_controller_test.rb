require 'test_helper'

module BlogDashboard
  class CategoriesControllerTest < ActionController::TestCase


    def setup
      super
      mock_login
    end

    def create_category
      @category = Category.create(name: 'foo')
    end

    test "should get index" do
      get :index, use_route: :blog_dashboard
      assert_response :success
      assert_not_nil assigns(:categories)
    end

    test "should get new" do
      get :new, use_route: :blog_dashboard
      assert_response :success
      assert_not_nil assigns(:category)
      assert_template("new")
    end

    test "should redirect to edit if valid on create" do
      post :create, use_route: :blog_dashboard, category: {name: 'foo'}
      assert_redirected_to [:edit, assigns(:category)]
    end

    test "should render new if validations fails on create" do
      post :create, use_route: :blog_dashboard
      assert_response 200
      assert_template("new")
    end

    test "should get edit" do
      create_category
      get :edit, use_route: :blog_dashboard, id: @category.to_param
      assert_response :success
      assert_not_nil assigns(:category)
      assert_template("edit")
    end

    test "should redirect to edit if valid on update" do
      create_category
      put :update, use_route: :blog_dashboard, category: {name: 'foo'}, id: @category.to_param
      assert_redirected_to [:edit, assigns(:category)]
    end

    test "should render edit if validations fails on update" do
      create_category
      put :update, use_route: :blog_dashboard, id: @category.to_param, category: {name: ''}
      assert_response 200
      assert_template("edit")
    end

    test "should redirect to categories" do
      create_category
      delete :destroy, use_route: :blog_dashboard, id: @category.to_param
      assert_redirected_to [:categories]
    end

  end
end
