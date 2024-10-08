class ActionItem < ApplicationRecord
  acts_as_paranoid
  has_paper_trail
  
  belongs_to :task
  belongs_to :itemable, polymorphic: true

  enum status: { not_started: 0, started: 1, completed: 2 }

  validates :name, presence: true
  validates :status, presence: true
end
