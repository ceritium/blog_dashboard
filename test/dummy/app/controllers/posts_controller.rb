# encoding: UTF-8
class PostsController < ApplicationController

  def index
    @posts = Post.page(params[:page]).published
    if params[:category_id]
      if @category = Category.find(params[:category_id])
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
      redirect_to post_path(@post, anchor: comment.to_param), notice: 'Comment created'
    else
      flash[:error] = 'Comment not created'
      redirect_to post_path(@post)
    end
  end

  private

  def get_post
    @post = Post.find(params[:id])
  end
end
