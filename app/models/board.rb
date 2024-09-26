class Board < ApplicationRecord
    has_many :columns, dependent: :destroy
    has_many :tasks, dependent: :destroy
    validates :name, presence: true
end
