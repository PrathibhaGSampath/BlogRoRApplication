class SentMailOnPostPublishedJob < ApplicationJob
  queue_as :default

  def perform(user_id, post_id)
    if user_id.present? && post_id
      user = User.find_by_id(user_id)
      post = Post.find_by_id(post_id)
      UserMailer.notice_on_published_post(user.email, post.title).deliver_now
    end
  end
end
