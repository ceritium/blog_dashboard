require_dependency "blog_dashboard/application_controller"

module BlogDashboard

  # Using explicit ::BlogDashboard::ApplicationController fixes NoMethodError 'blog_dashboard_authenticate' in
  # the main_app
  class PostsController < ::BlogDashboard::ApplicationController

    # If a layout is specified, use that. Otherwise, fall back to the default
    layout BlogDashboard.configuration.layout if BlogDashboard.configuration.layout

    blog_dashboard_authenticate

    def index
      @posts = Post.page(params[:page])
    end

    def new
      @post = Post.new(author: current_user)
    end

    def create
      @post = Post.new(params[:post])
      @post.state = params[:button]
      if @post.save
        redirect_to [:edit, @post], notice: 'Post created'
      else
        render 'new'
      end
    end

    def edit
      get_post
    end

    def update
      get_post
      @post.state = params[:button]
      if @post.update_attributes(params[:post])
        redirect_to [:edit, @post], notice: 'Post updated'
      else
        render 'edit'
      end
    end

    def destroy
      get_post
      @post.destroy
      redirect_to [:posts], notice: "Post deleted"
    end


    private

    def get_post
      @post = Post.find(params[:id])
    end


  end
end
