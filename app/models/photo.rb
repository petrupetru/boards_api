class Photo < ApplicationRecord
    has_one :action_items, as: :itemable, dependent: :destroy
end
