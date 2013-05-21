class PostsController < ApplicationController

  def index
    @posts = BlogDashboard::Post.page(params[:page])
  end

  def show
    @post = BlogDashboard::Post.find(params[:id])
  end
end
