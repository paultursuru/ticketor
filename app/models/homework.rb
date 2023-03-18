class Homework < ApplicationRecord
  belongs_to :user
  before_create :destroy_first_homework, if: :has_another_homework?

  validates :title, :url, presence: true

  scope :graded, -> { where.not(grade: nil)}
  # Ex:- scope :active, -> {where(:active => true)}

  def today?
    created_at.day == Date.today.day
  end

  def username
    user.username
  end

  def graded?
    !grade.nil?
  end

  def self.to_csv
    require "csv"
    attributes = %w{username email grade url }

    CSV.generate(headers: true) do |csv|
      csv << attributes

      graded.each do |homework|
        csv << [homework.username, homework.user.email, homework.grade, homework.url]
      end
    end
  end

  def destroy_first_homework
    user.homeworks.first.destroy
  end

  def has_another_homework?
    user.homeworks.count >= 1
  end
end
