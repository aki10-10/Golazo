class Admin::BlogsController < ApplicationController
  def index
    #新規投稿順での表示
    @blogs = Blog.all.order(created_at: :desc)
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = Blog.find(params[:id])
  end
  
  def destroy
    @blog = Blog.find(params[:id])
    @blog.delete
    redirect_to admin_blogs_path
  end
  
  private
  
  def blog_params
    params.require(:blog).permit(:title, :body, :image, :blog_id)
  end  
end
