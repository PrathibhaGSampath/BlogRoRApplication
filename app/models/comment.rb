class Comment < ApplicationRecord
  include TextValidation
  belongs_to :post

  validates_presence_of :description
  validates_length_of :description, maximum: 100
  before_save :validate_comment_description, :update_word_count

  def validate_comment_description
    if contains_wrong_words?(self.description)
      self.errors.add(:base, "Comment should not contain bad words like ('bad', 'poor', 'stupid', 'filty', 'dirty')")
      throw :abort
    end
  end

  def update_word_count
    self.word_count = Comment.get_word_count(self.description)
  end
end
