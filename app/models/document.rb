class Document < ApplicationRecord
    acts_as_paranoid
    has_paper_trail
    
    has_one :action_items, as: :itemable, dependent: :destroy
    validates :document_link, presence: true
end
