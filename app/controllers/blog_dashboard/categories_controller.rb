require_dependency "blog_dashboard/application_controller"

module BlogDashboard
  class CategoriesController < ::BlogDashboard::ApplicationController

    blog_dashboard_authenticate

    def index
      @categories = Category.page(params[:page])
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(params[:category])
      if @category.save
        redirect_to edit_category_path(@category), notice: 'Category created'
      else
        render 'new'
      end
    end

    def edit
      get_category
    end

    def update
      get_category
      if @category.update_attributes(params[:category])
        redirect_to edit_category_path(@category), notice: "Category updated"
      else
        render 'edit'
      end
    end

    def destroy
      get_category
      @category.delete
      redirect_to categories_path, notice: 'Category deleted'
    end

    private

    def get_category
      @category = Category.find(params[:id])
    end
  end
end
