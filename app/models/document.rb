class Document < ApplicationRecord
    acts_as_paranoid
    has_one :action_items, as: :itemable, dependent: :destroy
end
