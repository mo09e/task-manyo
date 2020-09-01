class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :content, presence: true, length: { in: 1..200 }

  scope :task_name_search, ->(params) { where("task_name LIKE ?", "%#{params}%") }
end
