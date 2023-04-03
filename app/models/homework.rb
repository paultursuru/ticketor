class Homework < ApplicationRecord
  belongs_to :user
  before_validation :can_still_be_posted?, on: :create

  validates :title, :url, presence: true

  scope :graded,     -> { where.not(grade: [nil, ""])}
  scope :not_graded, -> { where(grade: [nil, ""])}

  def today?
    created_at.day == Date.today.day
  end

  def username
    user.username
  end

  def graded?
    !grade.nil?
  end

  def not_zero?
    grade != 0
  end

  def self.to_csv
    require "csv"
    attributes = %w{username email grade title url }

    CSV.generate(headers: true) do |csv|
      csv << attributes

      graded.each do |homework|
        csv << [homework.username, homework.user.email, homework.grade, homework.title, homework.url]
      end
    end
  end

  def can_still_be_posted?
    if user_has_more_than_one_homework? && teacher_graded_this_student_already?
      errors.add(:base, "You already have one graded homework")
      false
    elsif user_has_more_than_one_homework?
      user.homeworks.first.destroy
    else
      true
    end
  end

  def user_has_more_than_one_homework?
    user.has_a_homework?
  end

  def teacher_graded_this_student_already?
    user.homeworks.graded.any?
  end
end
