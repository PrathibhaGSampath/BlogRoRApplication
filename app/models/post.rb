class Post < ApplicationRecord
  include TextValidation
  belongs_to :user
  has_many :comments, as: :opinion, dependent: :destroy

  validates_length_of :title, maximum: 50
  validates_length_of :body, maximum: 200
  validates_presence_of :title, :body
  validates_inclusion_of :status, :in => %w( Draft Published Archived)
  before_save :verify_draft_post

  DEFAULT_POST_STATUS = {"draft": "Draft", "published": "Published", "archived": "Archived"}

  scope :get_posts, -> (user_id, status) {where("user_id = ? AND status = ?", "#{user_id}", "#{status}")}
  scope :get_draft_post, -> (user_id) { where("user_id = ? AND status = ?", "#{user_id}", "#{DEFAULT_POST_STATUS[:draft]}") }

  def verify_draft_post
    user_id = self.user_id
    if Post.get_draft_post(user_id).present?
      errors.add('You already have one draft post.')
    end
  end
end
