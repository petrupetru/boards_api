class Task < ApplicationRecord
    acts_as_paranoid
    has_paper_trail

    has_and_belongs_to_many :users
    belongs_to :column
    belongs_to :board
    has_many :action_items, dependent: :destroy
    
    validates :type, presence: true
    validates :title, presence: true

    enum status: { active: 0, completed: 1, archived: 2 }
    

    #scope pe task pentru toate taskurile arhivate de peste 3 zile
    scope :archived_days_ago, -> (days){ where(status: :archived).where('archived_at < ?', days.day.ago) }

    #scope pentru toate taskurile active din coloana delivered
    scope :active_delivered, -> { joins(:column).where(status: :active, 'columns.name' => "delivered") }

end
