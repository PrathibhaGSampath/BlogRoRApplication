class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @comment = Comment.new
    @post = Post.where("id = ?","#{params[:post_id]}").first
  end

  def create
    new_comment = Comment.new(create_permit_parameter)
    new_comment[:user_id] = current_user.id
    new_comment[:post_id] = params[:post_id]
    if new_comment.save
      redirect_to posts_path, notice: "Commented created successfully."
    else
      message = new_post.errors[:base].last.to_s if new_comment.errors[:base].present?
      message ||= "Could not be able to create post. Make sure comment is present."
      redirect_to new_post_comment_path, alert: message
    end
  end

  def edit
    @comment = Comment.where('id=?', params[:id]).first
    @post = Post.where("id = ?","#{params[:post_id]}").first
  end

  def update
    @comment = Comment.where('id = ?', params[:id]).first
    if @comment.present?
      if @comment.update(update_permit_parameter)
        redirect_to posts_path
      else
        message = @comment.errors[:base].last.to_s if @comment.errors[:base].present?
        message ||= "Could not be able to create post. Make sure comment is present."
        redirect_to edit_post_comment_path, alert: message
      end
    else
      redirect_to edit_post_comment_path
    end
  end

  def destroy
    @comments = Comment.where('id = ?', params[:id]).first
    if current_user.id == @comments.user_id
      if @comments.present?
        if @comments.destroy
          redirect_to posts_path, notice: "Deleted successfully"
        else
          redirect_to posts_path,  alert: "Could not delete the Comments"
        end
      else
        redirect_to posts_path,  alert: "You can't delete the Comment"
      end
    end
  end

  private
  def create_permit_parameter
    params.require(:comment).permit( :description)
  end

  def update_permit_parameter
    params.require(:comment).permit(:description)
  end
end
