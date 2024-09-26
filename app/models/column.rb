class Column < ApplicationRecord
    belongs_to :board
    validates :name, presence: true
    has_many :tasks, dependent: :destroy
end
