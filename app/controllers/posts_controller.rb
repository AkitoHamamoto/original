class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all.order("number ASC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post =Post.find(params[:id])
  end

  def update
    @post =Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @posts = Post.all.order("number ASC")
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user.authority == true 
      @post.destroy
      redirect_to posts_path
    else
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:number, :title, :video, :text, :mark, :image, documents:[ ]).merge(user_id: current_user.id)
  end

end
