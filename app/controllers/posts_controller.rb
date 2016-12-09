class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :show, :destroy, :is_author?]
  before_action :require_author, only: [:edit, :update, :destroy]

  helper_method :is_author?

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      flash[:notice] = 'Post updated successfully'
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
  end

  def destroy
    @post.destroy!
    redirect_to sub_url(@post.sub_id)
  end

  def is_author?
    @post.author == current_user
  end

  private

  def require_author
    redirect_to post_url(@post) unless is_author?
  end

  def set_post
    @post = Post.find_by_id(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
end
