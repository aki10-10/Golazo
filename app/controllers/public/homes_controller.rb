class Public::HomesController < ApplicationController
  def top
    @blogs = Blog.all.order(created_at: :desc).page(params[:page]).per(10)
  end
end
