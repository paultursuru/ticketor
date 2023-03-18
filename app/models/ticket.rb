class Ticket < ApplicationRecord
  before_save :attribute_teacher!, if: :teacher_is_empty?
  belongs_to :user
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'

  validates :content, presence: true

  scope :from_today, -> { where("created_at <= ? ", Date.today)}
  scope :from_day, ->(argument){ where("created_at <= ? ", argument).where("created_at >= ? ", argument - 1.days ) }

  enum status: [:pending, :resolved]

  # after_create_commit -> { broadcast_prepend_to "tickets", partial: "tickets/ticket", locals: { ticket: self } }

  def attribute_teacher!
    self.teacher_id = User.ticketable.sample.id
  end

  def today?
    created_at.day == Date.today.day
  end

  def duration
    (updated_at - created_at).round
  end

  private


  def teacher_is_empty?
    teacher_id.nil?
  end
end
