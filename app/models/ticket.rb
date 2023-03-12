class Ticket < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  enum status: [:pending, :resolved]

  def today?
    created_at.day == Date.today.day
  end

  def duration
    (updated_at - created_at).round
  end
end
