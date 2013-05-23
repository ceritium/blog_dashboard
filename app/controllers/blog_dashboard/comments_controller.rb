require_dependency "blog_dashboard/application_controller"

module BlogDashboard
  class CommentsController < ::BlogDashboard::ApplicationController
    # If a layout is specified, use that. Otherwise, fall back to the default
    layout BlogDashboard.configuration.layout if BlogDashboard.configuration.layout

    blog_dashboard_authenticate

    def index
      @comments = Comment.page(params[:page])
      if params[:post_id]
        @post = Post.find(params[:post_id])
        @comments = @comments.where(post_id: params[:post_id])
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to :back, notice: 'Comment deleted'
    end
  end
end
