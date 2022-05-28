class Public::CommentsController < ApplicationController
  def create
    blog = Blog.find(params[:blog_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.blog_id = blog.id
    if comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to public_blog_path(params[:blog_id])
  end

  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end

