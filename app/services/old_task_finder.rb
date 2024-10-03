class OldTaskFinder 
    def call(board)
        board.tasks.where('created_at < ?', 1.day.ago).where.not(status: :archived).where.not("LOWER(title) LIKE '%test%'")
        #de adaugat criterii
    end
end
