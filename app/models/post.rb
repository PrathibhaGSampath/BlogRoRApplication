class Post < ApplicationRecord
  include TextValidation
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates_length_of :title, maximum: 50
  validates_length_of :body, maximum: 200
  validates_presence_of :title, :body
  validates_inclusion_of :status, :in => %w( Draft Published Archived)
  before_save :verify_draft_post, :validate_post_body, :update_word_count
  after_create :send_mail_for_newly_published_posts
  DEFAULT_POST_STATUS = {"Draft": "Draft", "Published": "Published", "Archived": "Archived"}


  scope :get_user_posts_with_status, -> (user_id, status) {where("user_id = ? AND status = ?", "#{user_id}", "#{status}")}
  scope :get_draft_post, -> (user_id) { where("user_id = ? AND status = ?", "#{user_id}", "#{DEFAULT_POST_STATUS[:Draft]}") }

  def verify_draft_post
    user_id = self.user_id
    if self.status == DEFAULT_POST_STATUS[:Draft] && Post.get_draft_post(user_id).present?
      self.errors.add(:base, 'You already have one draft post. Try creating Publish/Archive posts')
      throw :abort
    end
  end

  def validate_post_body
    if contains_wrong_words?(self.body)
      self.errors.add(:base, "Post Information contain bad words ('bad', 'poor', 'stupid', 'filty', 'dirty')")
      throw :abort
    end
  end

  def self.available_post_status
    return DEFAULT_POST_STATUS
  end

  def update_word_count
    self.word_count = Post.get_word_count(self.body)
  end

  def send_mail_for_newly_published_posts
    if self.status == DEFAULT_POST_STATUS["Published"]
      SentMailOnPostPublishedJob.perform_now(self.user_id, self.id)
    end
  end

end
