class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @comment = Comment.new
    @post = Post.where("post_id = ?","#{params[:post_id]}")
  end

  def index
    @comments = Comment.all
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def create_permit_parameter
    params.require(:posts).permit(:title, :body)
  end

  def update_permit_parameter
    params.require(:posts).permit(:title, :body)
  end
end
