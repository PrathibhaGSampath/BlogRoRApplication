class PostsController < ApplicationController
  include PostsHelper

  before_filter :authenticate_user!

  def new
    @post = Post.new
    @available_status =  Post.available_post_status
  end

  def index
    @draft_posts = Post.get_user_posts_with_status(current_user.id, 'Draft')
    @published_posts = Post.get_user_posts_with_status(current_user.id, 'Published')
    @archived_posts = Post.get_user_posts_with_status(current_user.id,'Archived')
  end

  def published_posts
    @published_posts = Post.get_user_posts_with_status(current_user.id, 'Published')
  end

  def activate_post
    @post = Post.where("id = ?", params[:id])
    if @post.present?
      if @post.update(status: "Published")
        flash[:notice] = "Published successfully!!!"
      else
        flash[:error] = "Couldn't Archive the Post"
      end
    end
    redirect_to posts_path
  end

  def archive_post
    @post = Post.where("id = ?", params[:id])
    if @post.present?
      if @post.update(status: "Archived")
        flash[:notice] = "Archived successfully!!!"
      else
        flash[:error] = "Couldn't Archive the Post"
      end
    end
    redirect_to posts_path
  end

  def create
    new_post = Post.new(create_permit_parameter)
    new_post[:user_id] = current_user.id
    if new_post.save
      redirect_to posts_path, notice: "Post created successfully."
    else
      message = new_post.errors[:base].last.to_s if new_post.errors[:base].present?
      message ||= "Could not create new Post. Missing Post title/information"
      redirect_to new_post_path, alert: message
    end
  end

  def edit
    @post = Post.where('id=?', params[:id]).first
  end

  def update
    @post = Post.where('id = ?', params[:id]).first
    if @post.present?
      if @post.update(update_permit_parameter)
        redirect_to posts_path
      else
        redirect_to edit_post_path, id: params[:id]
      end
    else
      redirect_to edit_post_path, id: params[:id]
    end
  end

  def destroy
    @post = Post.where('id = ?', params[:id]).first
    if current_user.id == @post.user_id
      if @post.present?
        if @post.destroy
          flash[:notice] = "Deleted successfully"
        else
          flash[:alert] = "Could not delete the post"
        end
      else
        flash[:alert] =  "Could not delete the post"
      end
    end
    redirect_to posts_path
  end

  private
  def create_permit_parameter
    params.require(:post).permit(:title, :body,:status)
  end

  def update_permit_parameter
    params.require(:post).permit(:title, :body, :status)
  end
end
