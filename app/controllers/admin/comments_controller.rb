class Admin::CommentsController < ApplicationController
  def create
    blog = Blog.find(params[:Blog_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.blog_id = blog.id
    comment.save
    redirect_to admin_blog_path(blog)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_blog_path(params[:blog_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment,:blog_id)
  end
end
