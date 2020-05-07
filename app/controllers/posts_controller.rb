class PostsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def create
    new_post = Post.new(create_permit_parameter)
    new_post[:user_id] = current_user.id
    if new_post.save
      redirect_to posts_path, notice: "Post created successfully."
    else
      redirect_to new_post_path, alert: "Could not be able to create post. Make sure title and information present."
    end




  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def create_permit_parameter
    params.require(:post).permit(:title, :body)
  end

  def update_permit_parameter
    params.require(:post).permit(:title, :body)
  end
end
