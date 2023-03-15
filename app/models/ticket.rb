class Ticket < ApplicationRecord
  before_save :attribute_teacher!, if: :teacher_is_empty?
  belongs_to :user
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'

  validates :content, presence: true

  enum status: [:pending, :resolved]

  def today?
    created_at.day == Date.today.day
  end

  def duration
    (updated_at - created_at).round
  end

  private

  def attribute_teacher!
    teacher_id = User.ticketable.sample.id
  end

  def teacher_is_empty?
    teacher_id.nil?
  end
end
