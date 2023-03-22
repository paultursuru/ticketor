class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  enum status: ["student", "assistant", "teacher"]

  has_many :tickets, dependent: :destroy
  has_many :homeworks, dependent: :destroy

  validates :username, presence: true

  scope :ticketable, -> { where({ status: ["teacher", "assistant"]})}
  scope :with_no_homework, -> { student.where.not(id: Homework.all.pluck(:user_id)) }
  scope :with_homework, -> { student.where(id: Homework.all.pluck(:user_id)) }
  scope :homework_is_graded, -> { student.where(id: Homework.all.graded.pluck(:user_id)) }
  scope :homework_is_not_graded, -> { student.where(id: Homework.all.not_graded.pluck(:user_id)) }

  def is_team?
    assistant? || teacher?
  end

  def has_a_homework?
    homeworks.any? && (homeworks.count == 1 && homeworks.first.persisted?)
  end

  def is_graded?
    homeworks.graded.any?
  end
end
