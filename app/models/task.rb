class Task < ApplicationRecord
    acts_as_paranoid
    has_paper_trail

    has_and_belongs_to_many :users
    belongs_to :column
    belongs_to :board
    has_many :action_items, dependent: :destroy
    
    validates :type, presence: true
    
end
