class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :news

  scope :comment_by_date, -> { order created_at: :desc }
end
