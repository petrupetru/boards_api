class Column < ApplicationRecord
    acts_as_paranoid
    belongs_to :board
    validates :name, presence: true
    has_many :tasks, dependent: :destroy
end
