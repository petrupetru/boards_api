class ActionItem < ApplicationRecord
  belongs_to :task
  belongs_to :itemable, polymorphic: true

  enum status: { not_started: 0, started: 1, completed: 2 }
end
