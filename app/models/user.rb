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

  def is_team?
    assistant? || teacher?
  end

  def has_a_homework?
    homeworks.any?
  end
end