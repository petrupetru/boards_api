class TaskTracker
    def initialize(task_finder_service: OldTaskFinder.new)
        @task_finder_service = task_finder_service
    end
    def call
        tasks_to_archive_all = []
        Board.all.each { |board|
            tasks_to_archive_board = @task_finder_service.call(board).where.not(status: :archived)
            tasks_to_archive_all += tasks_to_archive_board
        }
        tasks_to_archive_all
    end
end