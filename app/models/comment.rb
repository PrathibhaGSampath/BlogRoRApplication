class Comment < ApplicationRecord
  include TextValidation
  belongs_to :post
  belongs_to :opinion, polymorphic: true

  validates_presence_of :description
  validates_length_of :description, maximum: 100
end
