class Role < ApplicationRecord
    acts_as_paranoid
    has_paper_trail

    has_and_belongs_to_many :users
    validates :name, presence: true
end
