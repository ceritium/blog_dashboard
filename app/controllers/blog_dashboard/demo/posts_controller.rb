require_dependency "blog_dashboard/application_controller"


class BlogDashboard::Demo::PostsController < ApplicationController

  layout 'blog_dashboard/demo'

  def index
    @posts = BlogDashboard::Post.page(params[:page]).published
    if params[:category_id]
      if @category = BlogDashboard::Category.find(params[:category_id])
        @posts = @posts.where(category_ids: @category.id)
      end
    end
  end

  def show
    get_post
  end

  def create_comment
    get_post
    comment = @post.comments.new(params[:comment])
    if comment.save
      redirect_to demo_post_path(@post, anchor: comment.to_param), notice: 'Comment created'
    else
      flash[:error] = 'Comment not created'
      redirect_to demo_post_path(@post)
    end
  end

  private

  def get_post
    @post = BlogDashboard::Post.find(params[:id])
  end

end