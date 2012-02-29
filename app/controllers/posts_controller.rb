# encoding: UTF-8

class PostsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user, :only => [:create, :destroy]

  def index
    @title = "Notícies"
    @posts = Post.paginate(:page => params[:page])
  end

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Notícia creada!"
    else
      render 'new'
    end
    redirect_to posts_path
  end

  def new
    @title = "Afegir una nova notícia"
    @post = Post.new
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Notícia eliminada."
    redirect_back_or posts_path
  end
end
