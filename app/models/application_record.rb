class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :ordered, -> { order(id: :asc) }
end
