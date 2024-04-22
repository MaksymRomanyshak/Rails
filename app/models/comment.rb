class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  validates :body, presence: true

  after_create :send_email

  private

  def send_email
    CommentMailer.with(user: user, comment: self).created.deliver_later
  end
end
