class Homework < ApplicationRecord
  belongs_to :user

  validates :title, :url, presence: true

  def today?
    created_at.day == Date.today.day
  end
end
