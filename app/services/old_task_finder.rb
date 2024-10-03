class OldTaskFinder 
    def call(board)
        board.tasks.where('created_at < ?', 1.day.ago)
        #de adaugat criterii
    end
end
