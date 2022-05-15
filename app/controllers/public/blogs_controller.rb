class Public::BlogsController < ApplicationController
  def new
    @bolg = Blog.new
  end  
  def create
    @blog = blog.new(bolg_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to public_blogs_path
    else
      render :new
    end  
  end
  
  def index
    @blogs = Blog.all
  end 
  
  def show
    @blog = Bolg.find(params[:id])
    @comment = Comment.new
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
 
  def update
    @blog =Blog.find(params[:id])
    @blog.update(blog_params)
    redirect_to public_blog_path
  end  
  
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to public_blogs_path
  end  
  
  private
  
  def blog_params
    params.require(:blog).permit(:title, :body)
  end  
end
