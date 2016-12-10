class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    # @comment.user_id = current_user.id
    @comment.author = current_user

    if @comment.save
      flash[:notice] = 'Comments was added successfully'
      redirect_to post_url(@comment.post_id)
    elsif @comment.parent_comment_id
      flash[:errors] = @comment.errors.full_messages
      redirect_to comment_url(@comment.parent_comment_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_post_comments_url(@comment.post_id)
    end
  end

  def show
    @comment = Comment.find_by_id(params[:id])
  end

  def upvote
    Vote.create!(value: 1, voteable_id: params[:id], voteable_type: "Comment")
    redirect_to post_url(params[:post_id])
  end

  def downvote
    Vote.create!(value: -1, voteable_id: params[:id], voteable_type: "Comment")
    redirect_to post_url(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
