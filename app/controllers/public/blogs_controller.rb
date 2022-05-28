class Public::BlogsController < ApplicationController
  def new
    @blog = Blog.new
  end
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    tag_list = params[:blog][:name].split(',')
    if @blog.save
      @blog.save_tag(tag_list)
      redirect_to public_blogs_path(@blog)
    else
      render :new
    end
  end

  def index
    @blogs = Blog.all.order(created_at: :desc).page(params[:page]).per(10)
    @tag_list = Tag.all
  end

  def show
    @blog = Blog.find(params[:id])
    @comment = Comment.new
    @comments = @blog.comments
    @blog_tags = @blog.tags
  end

  def edit
    @blog = Blog.find(params[:id])
    @tag_list = @blog.tags.pluck(:name).join(',')
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @blogs = Blog.joins(blog_tags: :tag).where(tags: {name: @tag.name}).order(created_at: :desc)
    #joinsでテーブル間を繋げる
  end


  def update
    @blog =Blog.find(params[:id])
    tag_list=params[:blog][:name].split(',')
    if @blog.update(blog_params)
        @blog.save_tag(tag_list)
        redirect_to public_blog_path(@blog.id),notice: "更新完了しました"
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to public_blogs_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body, :image)
  end
end
