class Photo < ApplicationRecord
    acts_as_paranoid
    has_paper_trail
    
    has_one :action_items, as: :itemable, dependent: :destroy
    validates :photo_source, presence: true
end
